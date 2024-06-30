import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InvoiceTemplate extends StatefulWidget {
  const InvoiceTemplate({Key? key}) : super(key: key);

  @override
  _InvoiceTemplateState createState() => _InvoiceTemplateState();
}

class _InvoiceTemplateState extends State<InvoiceTemplate> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Templates'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: invoiceTemplates.length,
              itemBuilder: (context, index) {
                final template = invoiceTemplates[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  
                   
                    child: Column(
                      children: [
                        Text("Select the desired template at time of invoicing"),
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Margin around the image
                          child: SizedBox(
                            height: 550, // Specify the height you want for the image
                            width: 500,
                            child: Container(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                                child: Image.asset(
                                  template.imagePath,
                                 
                                  width: 460,
                                ),
                              ),
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: invoiceTemplates.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8.0,
                dotWidth: 8.0,
                activeDotColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvoiceTemplateModel {
  final String name;
  final Color color;
  final String imagePath;

  InvoiceTemplateModel(this.name, this.color, this.imagePath);
}

final List<InvoiceTemplateModel> invoiceTemplates = [
  InvoiceTemplateModel('Classic', Colors.white, 'assets/invoice_1.png'),
  InvoiceTemplateModel('Professional',Colors.white, 'assets/invoice_3.png'),
  InvoiceTemplateModel('Simple', Colors.white, 'assets/invoice_4.png'),
   InvoiceTemplateModel('Simple', Colors.white, 'assets/invoice_2.png'),
  // Add more templates as needed
];
