# # import nltk
# # from nltk.corpus import wordnet
# # from nltk.tokenize import word_tokenize
# # from nltk.stem import WordNetLemmatizer
# # nltk.download('punkt')
# # nltk.download('averaged_perceptron_tagger')
# # nltk.download('wordnet')
# # from flask import Flask, jsonify, request

# # app = Flask(__name__)

# # @app.route('/autocomplete', methods=['GET','POST'])
# # def autocomplete():
# #   input_text = str(request.args.get('text')) 
# #   tokens = word_tokenize(input_text.lower())
# #   tagged = nltk.pos_tag(tokens)
# #   lemmatizer = WordNetLemmatizer()

# #   synonyms = []
# #   for word, tag in tagged:
# #     if tag.startswith('NN') or tag.startswith('VB'):
# #       for syn in wordnet.synsets(lemmatizer.lemmatize(word)):
# #         for lemma in syn.lemmas():
# #           synonyms.append(lemma.name())
  
# #   autocomplete_words = []
# #   for syn in set(synonyms):
# #     if syn.startswith(input_text.lower()):
# #       autocomplete_words.append(syn.capitalize())
# #   print(autocomplete_words[:5])
# #   return autocomplete_words[:5]

# # if __name__ == "__main__":
# #   app.run(debug=True)
# # import spacy
# # from flask import Flask, request, jsonify

# # # Load the language model
# # nlp = spacy.load('en_core_web_sm')

# # # Define the list of words to use for suggestions
# # word_list = ['apple', 'banana', 'cherry', 'dog', 'elephant', 'fish', 'grape', 'horse', 'iguana', 'jellyfish']

# # # Define a dictionary to hold personalized dictionary entries
# # personalized_dict = {}

# # app = Flask(__name__)
# # # @app.route('/hello')
# # # def hello():
# # #     return 'Hello, World!'

# # @app.route('/autocomplete', methods=['POST','GET'])
# # def autocomplete():
# #     # Get the input text from the request
# #     input_text = request.args['text']
    
# #     # Tokenize the input text
# #     doc = nlp(input_text)

# #     # Get the last token in the input text
# #     last_token = doc[-1]

# #     # Find words in the word list that start with the last token
# #     suggestions = [word for word in word_list if word.startswith(last_token.text)]

# #     # If there are no suggestions, ask the user if they want to add the word to the personalized dictionary
# #     if not suggestions:
# #         return jsonify({'suggestion': last_token.text, 'add_to_dict': True})

# #     # If there is only one suggestion, return it
# #     elif len(suggestions) == 1:
# #         return jsonify({'suggestion': suggestions[0], 'add_to_dict': False})

# #     # If there are multiple suggestions, ask the user to choose one
# #     else:
# #         return jsonify({'suggestions': suggestions, 'add_to_dict': False})

# # @app.route('/add_to_dict', methods=['POST'])
# # def add_to_dict():
# #     # Get the new word and its replacement from the request
# #     new_word = request.json['new_word']
# #     replacement = request.json['replacement']

# #     # Add the new word to the personalized dictionary
# #     personalized_dict[new_word] = replacement

# #     return jsonify({'status': 'success'})

# # if __name__ == '__main__':
# #     app.run(debug=True, port=5000)



# import re
# import string
# import nltk
# from nltk.corpus import words
# from flask import Flask, jsonify, request

# app = Flask(__name__)
# nltk.download('words')
# english_words = set(words.words())

# def remove_punctuations(text):
#     """
#     This function removes the punctuations from the given text.
#     """
#     return text.translate(str.maketrans('', '', string.punctuation))

# def correct_spelling(word):
#     """
#     This function corrects the spelling of the given word using the English dictionary.
#     """
#     if word.lower() in english_words:
#         return word
#     else:
#         for w in english_words:
#             if nltk.edit_distance(word, w) == 1:
#                 return w
#         return word
# @app.route('/autocomplete', methods=['GET','POST'])
# def autocomplete():
#     """
#     This function takes a partially typed word or sentence and suggests autocomplete options based on
#     the English dictionary. It also autocorrects the spelling of the input using NLP techniques.
#     """
#     text=str(request.args['text'])
#     text = remove_punctuations(text)
#     words = text.split()
#     last_word = words[-1] if words else ""
#     suggestions = []
    
#     for word in english_words:
#         if word.startswith(last_word):
#             suggestions.append(word)
    
#     if not suggestions:
#         return "No suggestions found."
    
#     if len(suggestions) == 1:
#         return suggestions[0]
    
#     if last_word:
#         corrected_word = correct_spelling(last_word)
#         if corrected_word != last_word:
#             suggestions = [suggestion.replace(last_word, corrected_word) for suggestion in suggestions]
#     # print(suggestions[:5])
#     return suggestions[:5]

# if __name__ == "__main__":
#     app.run(debug=True)

import collections
from flask import Flask, request, jsonify

app=Flask(__name__)
class Autocomplete:
    def __init__(self):
        self.words = collections.defaultdict(int)

    def train(self, text):
        for word in text.split():
            self.words[word.lower()] += 1
    @app.route('/autocomplete', methods=['GET','POST'])
    def get_completions(self, prefix, max_completions=5):
        prefix = prefix.lower()
        completions = []
        for word in self.words:
            if word.startswith(prefix):
                completions.append((word, self.words[word]))
        completions.sort(key=lambda x: x[1], reverse=True)
        return [c[0] for c in completions[:max_completions]]

if __name__ == '__main__':
    ac = Autocomplete()
    ac.train('The quick brown fox jumps over the lazy dog.')
    ac.train('Python is a high-level programming language.')
    ac.train('Python is used for web development, data analysis, and artificial intelligence.')
    prefix = input('Enter a prefix: ')
    completions = ac.get_completions(prefix)
    
    app.run(debug=True, port=5000)
    # print(completions)
