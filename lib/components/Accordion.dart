import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Accordion extends StatefulWidget {
  final List<Widget> children;

  Accordion({this.children: const []});

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  _ExpansionTileState _currentExpandedWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _currentExpandedWidget = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: List.generate(widget.children.length, (index) {
        return NotificationListener(
          child: widget.children[index],
          onNotification: (notification) {
            if (notification is ExpandAccordionPaneNotification) {
              if (_currentExpandedWidget != null &&
                  _currentExpandedWidget.mounted) {
                _currentExpandedWidget.isExpanded = false;
              }
              _currentExpandedWidget = null;

              if (notification.widget.isExpanded) {
                _currentExpandedWidget = notification.widget;
              }
              return true;
            }
            return false;
          },
        );
      }),
    );
  }
}

class ExpandAccordionPaneNotification extends Notification {
  final _ExpansionTileState widget;

  ExpandAccordionPaneNotification({@required this.widget});
}

class AccordionPane extends StatelessWidget {
  final Widget child;
  final Widget title;
  final Widget leading;
  final ValueChanged<bool> onExpansionChanged;
  final Color backgroundColor;
  final Widget trailing;

  AccordionPane({
    @required this.title,
    this.child,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _ExpansionItem(
        title: title,
        leading: leading,
        trailing: trailing,
        backgroundColor: backgroundColor,
        onExpansionChanged: onExpansionChanged,
        children: child != null ? <Widget>[child] : [],
      ),
    );
  }
}

const Duration _kExpand = const Duration(milliseconds: 200);

class _ExpansionItem extends StatefulWidget {
  const _ExpansionItem({
    Key key,
    this.leading,
    @required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children: const <Widget>[],
    this.trailing,
    this.initiallyExpanded: false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;
  final Color backgroundColor;
  final Widget trailing;
  final bool initiallyExpanded;

  @override
  _ExpansionTileState createState() => new _ExpansionTileState();
}

class _ExpansionTileState extends State<_ExpansionItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  set isExpanded(value) => _updateExpandState(value);

  get isExpanded => _isExpanded;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _headerColor = new ColorTween();
    _iconColor = new ColorTween();
    _iconTurns =
        new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
    _backgroundColor = new ColorTween();

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _updateExpandState(!_isExpanded);
    ExpandAccordionPaneNotification(widget: this).dispatch(context);
  }

  void _updateExpandState(value) {
    _isExpanded = value;
    setState(() {
      if (value)
        _controller.forward();
      else
        _controller.reverse().then<void>((value) {
          setState(() {
            // Rebuild without widget.children.
          });
        });
      PageStorage.of(context)?.writeState(context, value);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color titleColor = _headerColor.evaluate(_easeInAnimation);

    return new Container(
      decoration: new BoxDecoration(
        color:
            _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data:
                new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
            child: new ListTile(
              onTap: _handleTap,
              leading: widget.leading,
              title: new DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: titleColor),
                child: widget.title,
              ),
              trailing: widget.trailing ??
                  new RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.expand_more),
                  ),
            ),
          ),
          new ClipRect(
            child: new Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _headerColor
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : new Column(children: widget.children),
    );
  }
}
