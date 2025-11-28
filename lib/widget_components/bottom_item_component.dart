import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomItem {
  BottomNavigationBarItem item({
    bool home = false,
    bool entry = false,
    bool analytics = false,
    bool history = false,
    bool settings = false,
  }) {
    return BottomNavigationBarItem(
      label: "",
      activeIcon: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(99, 183, 254, 0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 5,
            children: [
              Icon(
                home ? Icons.home:
                history
                    ? Icons.history
                    : settings
                    ? Icons.settings
                    : null,
                size: 30,
              ),
              Text(
                home
                    ? "Dashboard"
                    : history
                    ? "History"
                    : settings
                    ? "Settings"
                    : "",
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(
                      99, 183, 254, 0.9490196078431372),
                ),
              ),
            ],
          ),
        ),
      ),
      icon: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(99, 183, 254, 0),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 5,
            children: [
              Icon(
                home
                    ? Icons.home
                    : history
                    ? Icons.history
                    : settings
                    ? Icons.settings
                    : null,
                size: 30,
              ),
              Text(
                home
                    ? "Dashboard"
                    : history
                    ? "History"
                    : settings
                    ? "Settings"
                    : "",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
