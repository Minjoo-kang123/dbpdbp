package python;

import java.io.File;

import jep.JepException;
import jep.SharedInterpreter;

public class recModel {
	
	public int recommandBook(String title) throws JepException {
		//File modelFile = new File("src/python/decisionModel.pkl");
		//File tokenFile = new File("src/python/token.pkl");
		Integer result;
		//System.out.println(modelFile.getAbsolutePath().replace("\\", "/" ));
		SharedInterpreter jep = new SharedInterpreter();
					
		jep.eval("import pandas as pd");
		jep.eval("import numpy as np");
		jep.eval("from tensorflow.keras.preprocessing.text import Tokenizer");
		jep.eval("from tensorflow.keras.preprocessing.sequence import pad_sequences");
		jep.eval("import pickle");
					
		//jep.eval("model = pickle.load(open('" + modelFile.getAbsolutePath().replace("\\", "/" ) + "', 'rb'))");
		//jep.eval("with open('" + tokenFile.getAbsolutePath().replace("\\", "/" ) + "', 'rb') as handle:\r\n" + 
				//"		tokenizer = pickle.load(handle)");

		jep.eval("model = pickle.load(open('C:/Users/nabib/Documents/GitHub/dbpdbp/team/bookService/src/python/decisionModel.pkl', 'rb'))");
		jep.eval("with open('C:/Users/nabib/Documents/GitHub/dbpdbp/team/bookService/src/python/token.pkl', 'rb') as handle:\r\n" + 
				"		tokenizer = pickle.load(handle)");
			
		jep.eval("stopwords = ['도', '는', '다', '의', '가', '이', '은', '한', '에', '하', '고', '을', '를', '인', '듯', '과', '와', '네', '들', '듯', '지', '임', '게']");
			
		jep.eval("new_sentence = [word for word in '"+ title + "' if not word in stopwords]");
		jep.eval("encoded = tokenizer.texts_to_sequences(new_sentence)"); 
		jep.eval("result = []");
		jep.eval("for i in range(len(encoded)):\r\n" + 
				"  if (encoded[i] == []):\r\n" + 
				"    result.append(0)\r\n" + 
				"  else:\r\n" + 
				"    result.append(int(encoded[i][0]))");
		jep.eval("encoded = [np.array(result)]");
		jep.eval("pad_new = pad_sequences(encoded, maxlen = 30)");
		jep.eval("score = model.predict(pad_new)");
			
		result = Integer.parseInt(String.valueOf(jep.getValue("score[0]")));
			
		jep.close();
		
		return result;
	}

}
