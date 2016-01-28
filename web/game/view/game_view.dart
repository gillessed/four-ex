library game_view;

import 'dart:html' hide Dimension, Event;
import 'dart:async';
import 'dart:math';
import '../../ui/view.dart';
import '../../ui/theme.dart';
import '../../ui/transformation/transformation.dart';
import '../model/model.dart';
import '../rest/rest_controller.dart';

part 'icons/icons.dart';
part 'hud/turn_button.dart';
part 'hud/context_button.dart';
part 'hud/hud_bar.dart';
part 'menu/main_view.dart';
part 'menu/main_menu_view.dart';
part 'menu/terminal.dart';
part 'menu/vertical_scroll_view_depr.dart';
part 'context/context_view.dart';
part 'context/space/space_context_view.dart';
part 'context/space/space_context_button.dart';
part 'context/space/space_view.dart';
part 'context/space/status_bar/minimap_view.dart';
part 'context/space/status_bar/status_bar_view.dart';
part 'context/space/status_bar/blank_status_view.dart';
part 'context/space/status_bar/star_system_status_view.dart';
part 'context/influence/influence_context_view.dart';
part 'context/influence/influence_context_button.dart';
part 'context/colonies/colonies_context_view.dart';
part 'context/colonies/colonies_context_button.dart';
part 'context/colonies/colony_improvement_view.dart';
part 'context/colonies/colony_status.dart';
part 'context/colonies/tile_view/colony_tile_view.dart';
part 'context/colonies/tile_view/lattice_view.dart';
part 'context/colonies/tile_view/tile_status.dart';
part 'context/colonies/improvements/improvement_list.dart';
part 'context/colonies/improvements/build_queue.dart';
part 'context/colonies/ships/ship_list.dart';
part 'context/colonies/ships/ship_queue.dart';
part 'context/research/research_context_view.dart';
part 'context/research/research_context_button.dart';
part 'context/research/technology_bubble.dart';
part 'context/research/technology_popup.dart';
part 'context/research/technology_layer.dart';
part 'context/economy/economy_context_view.dart';
part 'context/economy/economy_context_button.dart';
part 'context/diplomacy/diplomacy_context_view.dart';
part 'context/diplomacy/diplomacy_context_button.dart';

class GameView extends View {
  
  Game model;
  HudBar hudBar;
  ContextView currentContextView;
  List<ContextView> contextViews;
  
  GameView(Theme theme, this.model): super(uiTheme: theme) {
    currentContextView = new SpaceContextView(model, this);
    contextViews = [
      currentContextView,
      new InfluenceContextView(model, this),
      new ColoniesContextView(model, this),
      new ResearchContextView(model, this),
      new EconomyContextView(model, this),
      new DiplomacyContextView(model, this)
    ];
    addChild(
      currentContextView,
      new Placement(
        (parentWidth, parentHeight) {
          return new Translation(0, HudBar.HUD_BAR_HEIGHT);
        },
        (parentWidth, parentHeight) {
          return new Dimension(parentWidth, parentHeight - HudBar.HUD_BAR_HEIGHT);
        }
      )
    );
    hudBar = new HudBar(model, this);
    addChild(
      hudBar,
      new Placement(
        Translation.ZERO_F,
        Dimension.NO_OP)
    );
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
  
  void switchContextView(ContextView contextView) {
    if(contextView != currentContextView) {
      replaceChild(currentContextView, contextView);
      currentContextView = contextView;
    }
  }
}