function [score] = cosine_similarity(vector1, vector2)
    %computes consine similarity between two input vectors
    score = vector1'*vector2/sqrt(sum((vector1).^2))/sqrt(sum((vector2).^2));
end

