import 'package:accessibility_audit/library/pluto_grid/src/helper/pluto_move_direction.dart';
import 'package:accessibility_audit/library/pluto_grid/src/manager/shortcut/pluto_grid_shortcut_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPlutoOptions {
  static Map<ShortcutActivator, PlutoGridShortcutAction> shortcut = {
    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
        const PlutoGridActionMoveCellFocus(PlutoMoveDirection.left),
    LogicalKeySet(LogicalKeyboardKey.arrowRight):
        const PlutoGridActionMoveCellFocus(PlutoMoveDirection.right),
    LogicalKeySet(LogicalKeyboardKey.arrowUp):
        const PlutoGridActionMoveCellFocus(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.arrowDown):
        const PlutoGridActionMoveCellFocus(PlutoMoveDirection.down),
    // Move selected cell focus
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowLeft):
        const PlutoGridActionMoveSelectedCellFocus(PlutoMoveDirection.left),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowRight):
        const PlutoGridActionMoveSelectedCellFocus(PlutoMoveDirection.right),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowUp):
        const PlutoGridActionMoveSelectedCellFocus(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowDown):
        const PlutoGridActionMoveSelectedCellFocus(PlutoMoveDirection.down),
    // Move cell focus by page vertically
    LogicalKeySet(LogicalKeyboardKey.pageUp):
        const PlutoGridActionMoveCellFocusByPage(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.pageDown):
        const PlutoGridActionMoveCellFocusByPage(PlutoMoveDirection.down),
    // Move cell focus by page vertically
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.pageUp):
        const PlutoGridActionMoveSelectedCellFocusByPage(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.pageDown):
        const PlutoGridActionMoveSelectedCellFocusByPage(
            PlutoMoveDirection.down),
    // Move page when pagination is enabled
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.pageUp):
        const PlutoGridActionMoveCellFocusByPage(PlutoMoveDirection.left),
    LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.pageDown):
        const PlutoGridActionMoveCellFocusByPage(PlutoMoveDirection.right),
    // Default tab key action
    LogicalKeySet(LogicalKeyboardKey.tab): const PlutoGridActionDefaultTab(),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.tab):
        const PlutoGridActionDefaultTab(),
    // Default enter key action
    LogicalKeySet(LogicalKeyboardKey.enter):
        const PlutoGridActionDefaultEnterKey(),
    LogicalKeySet(LogicalKeyboardKey.numpadEnter):
        const PlutoGridActionDefaultEnterKey(),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.enter):
        const PlutoGridActionDefaultEnterKey(),
    // Default escape key action
    LogicalKeySet(LogicalKeyboardKey.escape):
        const PlutoGridActionDefaultEscapeKey(),
    // Move cell focus to edge
    LogicalKeySet(LogicalKeyboardKey.home):
        const PlutoGridActionMoveCellFocusToEdge(PlutoMoveDirection.left),
    LogicalKeySet(LogicalKeyboardKey.end):
        const PlutoGridActionMoveCellFocusToEdge(PlutoMoveDirection.right),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.home):
        const PlutoGridActionMoveCellFocusToEdge(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.end):
        const PlutoGridActionMoveCellFocusToEdge(PlutoMoveDirection.down),
    // Move selected cell focus to edge
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.home):
        const PlutoGridActionMoveSelectedCellFocusToEdge(
            PlutoMoveDirection.left),
    LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.end):
        const PlutoGridActionMoveSelectedCellFocusToEdge(
            PlutoMoveDirection.right),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
            LogicalKeyboardKey.home):
        const PlutoGridActionMoveSelectedCellFocusToEdge(PlutoMoveDirection.up),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
            LogicalKeyboardKey.end):
        const PlutoGridActionMoveSelectedCellFocusToEdge(
            PlutoMoveDirection.down),
    // Set editing
    LogicalKeySet(LogicalKeyboardKey.f2): const PlutoGridActionSetEditing(),
    // Focus to column filter
    LogicalKeySet(LogicalKeyboardKey.f3):
        const PlutoGridActionFocusToColumnFilter(),
    // Toggle column sort
    LogicalKeySet(LogicalKeyboardKey.f4):
        const PlutoGridActionToggleColumnSort(),
    // Copy the values of cells
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
        const PlutoGridActionCopyValues(),
    // Paste values from clipboard
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyV):
        const PlutoGridActionPasteValues(),
    // Select all cells or rows
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
        const PlutoGridActionSelectAll(),
  };
}
