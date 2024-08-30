import nltk
import numpy as np
from nltk.tokenize import sent_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

nltk.download('punkt')

def text_tiling(text, window_size=10):
    sentences = sent_tokenize(text)
    
    # Create blocks of sentences
    blocks = [' '.join(sentences[i:i+window_size]) for i in range(0, len(sentences), window_size)]
    
    # Calculate TF-IDF
    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(blocks)
    
    # Calculate cosine similarity between adjacent blocks
    similarities = [cosine_similarity(tfidf_matrix[i:i+1], tfidf_matrix[i+1:i+2])[0][0] 
                    for i in range(len(blocks)-1)]
    
    # Find topic boundaries
    mean_sim = np.mean(similarities)
    std_sim = np.std(similarities)
    threshold = mean_sim - std_sim / 2
    boundaries = [i for i, sim in enumerate(similarities) if sim < threshold]
    
    # Create paragraphs
    paragraphs = []
    last_boundary = 0
    for boundary in boundaries:
        paragraphs.append(' '.join(sentences[last_boundary:(boundary+1)*window_size]))
        last_boundary = (boundary+1)*window_size
    paragraphs.append(' '.join(sentences[last_boundary:]))
    
    return '\n\n'.join(paragraphs)

# Read the input file
with open('output.txt', 'r') as f:
    text = f.read()

# Apply TextTiling
segmented_text = text_tiling(text)

# Write the segmented text to a new file
with open('segmented_output.txt', 'w') as f:
    f.write(segmented_text)

print("Topic segmentation complete. Output saved in segmented_output.txt")
