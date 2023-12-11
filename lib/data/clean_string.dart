
String convertToEnglish(String input) {
  Map<String, String> nonEnglishChars = {
    'Á': 'A', 
    'á': 'a', 
    'É': 'E', 
    'é': 'e', 
    'Í': 'I', 
    'í': 'i',
    'ï': 'i',
    'Ï': 'I',
    'Ó': 'O', 
    'ó': 'o',
    'Ð': 'D',
    'ð': 'd',
    'Ú': 'U', 
    'ú': 'u',
    'Ý': 'Y',
    'ý': 'y',
    'Ñ': 'N', 
    'ñ': 'n', 
    'Ç': 'C', 
    'ç': 'c', 
    'Å': 'A', 
    'å': 'a',
    'Ä': 'A', 
    'ä': 'a', 
    'Ö': 'O', 
    'ö': 'o', 
    'Ü': 'U', 
    'ü': 'u',
    'È': 'E',
    'è': 'e',
    'Ê': 'E', 
    'ê': 'e', 
    'Č': 'C',
    'č': 'c',
    'Š': 'S',
    'š': 's',
    'Ž': 'Z',
    'ž': 'z',
    'Æ': 'AE',
    'æ': 'ae',
    'ß': 'ss',
    '\'': '‘',
  };

  String result = '';
  for (int i = 0; i < input.length; i++) {
    String char = input[i];
    if (nonEnglishChars.containsKey(char)) {
      result += nonEnglishChars[char]!;
    } else {
      result += char;
    }
  }
  return result;
}