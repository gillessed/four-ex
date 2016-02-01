part of space_penguin;

enum Event {
ON_CHANGE,
KEY_UP,
KEY_DOWN,
MOUSE_WHEEL,
MOUSE_DOWN,
MOUSE_UP,
MOUSE_MOVED,
MOUSE_ENTERED,
MOUSE_EXITED
}

class EventListener {
  Map<Event, List<Function>> listeners;
  EventListener() {
    listeners = {};
    for(Event event in Event.values) {
      listeners[event] = [];
    }
  }

  void fire(Event event, var eventData) {
    listeners[event].forEach((Function listener) {
      listener(eventData);
    });
  }

  void on(Event event, Function function) {
    listeners[event].add(function);
  }

  void remove(Function function) {
    listeners.forEach((Event event, List<Function> listeners) {
      if(listeners.contains(function)) {
        listeners.remove(function);
      }
    });
  }

  bool consumes(Event event) => listeners[event].isNotEmpty;

  bool consumesMouseEvent() {
    return listeners[Event.MOUSE_DOWN].isNotEmpty
        || listeners[Event.MOUSE_UP].isNotEmpty
        || listeners[Event.MOUSE_WHEEL].isNotEmpty
        || listeners[Event.MOUSE_MOVED].isNotEmpty
        || listeners[Event.MOUSE_ENTERED].isNotEmpty
        || listeners[Event.MOUSE_EXITED].isNotEmpty;
  }
}