import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool isHomePage;
  final bool isSearch;
  final Widget? leadingButton;
  final List<Widget>? actionButtons;
  const CommonScaffold({
    Key? key,
    required this.title,
    required this.children,
    this.leadingButton,
    this.actionButtons,
    this.isSearch = false,
    this.isHomePage = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? null
          : AppBar(
              leading: leadingButton,
              actions: [
                if (actionButtons != null)
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.035,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actionButtons!,
                    ),
                  ),
              ],
            ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
                image: isHomePage
                    ? const DecorationImage(
                        image: AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  isHomePage ? 0 : MediaQuery.of(context).size.width * 0.025,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.88,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: isHomePage
                            ? MediaQuery.of(context).size.width * 0.05
                            : 0,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
