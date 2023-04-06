import nltk
from nltk.corpus import wordnet
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
nltk.download('punkt')
nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')

def autocomplete(input_text):
  tokens = word_tokenize(input_text.lower())
  tagged = nltk.pos_tag(tokens)
  lemmatizer = WordNetLemmatizer()

  synonyms = []
  for word, tag in tagged:
    if tag.startswith('NN') or tag.startswith('VB'):
      for syn in wordnet.synsets(lemmatizer.lemmatize(word)):
        for lemma in syn.lemmas():
          synonyms.append(lemma.name())
  
  autocomplete_words = []
  for syn in set(synonyms):
    if syn.startswith(input_text.lower()):
      autocomplete_words.append(syn.capitalize())
  return autocomplete_words[:5]