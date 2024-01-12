import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mobile/models/news_model.dart';
import 'package:mobile/models/news_summary.dart';

class SummarizeRepository {
  String apiKey = 'AIzaSyCmMrhYLYFFXLCga_TApJH3EQ3nQ7IsmKw';
  String url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=';

  Future<NewsSummaryModel> getNewsSummary(NewsModel newsModel) async {
    log('1');
    try {
      log('2');
      final uri = Uri.parse(url + apiKey);
      log('3');
      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {
                'text':
                    // ignore: leading_newlines_in_multiline_strings
                    '''Your task is to read the various news articles and summarize them in easy and simple language (English and Hinglish) so readers can understand the article properly and quickly. 

Note: Hinglish is a mixture of both English and Hindi which is generally used in India in day-to-day life The Summarize response must contain 80 to 100 words

Response: 
User: 
Summarize this article {https://www.denofgeek.com/movies/the-best-movies-of-2023/}
System: 
{"english": {"title": "The Best Movies of 2023 So Far","description": "A list of the best movies released in 2023 so far, according to Den of Geek.","summarize": "The list includes a variety of films, from big-budget blockbusters to smaller independent films. Some of the highlights include Everything Everywhere All at Once, The Batman, and Top Gun: Maverick. The list is sure to spark debate among movie fans, but it's a great starting point for anyone looking for the best movies to watch in 2023."},"hinglish": {"title": "2023 की अब तक की सबसे अच्छी फिल्में","description": "Den of Geek के अनुसार, 2023 में अब तक रिलीज़ हुई सबसे अच्छी फिल्मों की list।","summarize": "इस list में बड़े बजट की blockbusters से लेकर छोटी independent फिल्मों तक, विभिन्न प्रकार की फिल्में शामिल हैं। कुछ मुख्य आकर्षण में Everything Everywhere All at Once, The Batman और Top Gun: Maverick शामिल हैं। यह list निश्चित रूप से फिल्म प्रशंसकों के बीच बहस छेड़ देगी, लेकिन 2023 में देखने के लिए सबसे अच्छी फिल्मों की तलाश करने वालों के लिए यह एक शानदार शुरुआती बिंदु है।"}}


User: 
Summarize this article {https://www.denofgeek.com/movies/kang-the-conqueror-marvel-mess-jonathan-majors/}
System:
 {"english": {"title": "Kang the Conqueror: Marvel's Messy Introduction of a Major Villain","description": "An analysis of Marvel's handling of the character Kang the Conqueror in the MCU, and how it has been a mixed bag so far.","summarize": "Marvel's introduction of Kang the Conqueror in the MCU has been a bit of a mess. The character has been portrayed in different ways in different projects, and it's not always clear what his motivations are. This has led to some confusion among fans, and it's not clear how Marvel plans to resolve this going forward. Despite this, Jonathan Majors' performance as Kang has been praised, and there is still potential for the character to become a major villain in the MCU."},"hinglish": {"title": "कंग द कॉन्करर: मार्वल का एक प्रमुख विलेन का गड़बड़ परिचय","description": "MCU में कैरेक्टर कांग द कॉन्करर को मार्वल द्वारा संभालने का विश्लेषण, और यह अब तक कैसे एक मिश्रित बैग रहा है।","summarize": "MCU में कांग द कॉन्करर का मार्वल का परिचय थोड़ा गड़बड़ रहा है। कैरेक्टर को अलग-अलग प्रोजेक्ट्स में अलग-अलग तरीकों से चित्रित किया गया है, और यह हमेशा स्पष्ट नहीं होता कि उसकी प्रेरणाएँ क्या हैं। इससे प्रशंसकों में कुछ भ्रम पैदा हो गया है, और यह स्पष्ट नहीं है कि मार्वल आगे बढ़ने की योजना कैसे बना रहा है। इसके बावजूद, कांग के रूप में जोनाथन मेजर्स के प्रदर्शन की प्रशंसा की गई है, और अभी भी MCU में कैरेक्टर के एक प्रमुख विलेन बनने की संभावना है।"}}

User: 
Summarize this article ${newsModel.source}
System: ''',
              }
            ],
          }
        ],
        'generationConfig': {
          'temperature': 0.1,
          'topK': 1,
          'topP': 1,
          'maxOutputTokens': 16000,
          'stopSequences': <dynamic>[],
        },
      });
      log('4');
      final response = await http.post(uri, body: body);
      log('5');
      log('Response State Code: ${response.statusCode} - Response: $response');
      log('6');
      if (response.statusCode == 200) {
        log('7');
        final body = jsonDecode(response.body);
        log('8');
        final summary =
            body['candidates'][0]['content']['parts'][0]['text'] as String;
        log('9');
        log('summary: $summary');
        final result = NewsSummaryModel.fromJson(summary);
        log('10');
        return result;
      } else {
        log('11');
        throw Exception('something went wrong while Summarize news article');
      }
    } catch (e) {
      log('12 $e');
      throw Exception('Failed to Summarize news article $e');
    }
  }
}
