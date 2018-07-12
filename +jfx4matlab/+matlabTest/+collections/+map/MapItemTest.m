classdef MapItemTest < matlab.unittest.TestCase
    methods(Test)
        function initTest(testCase) 
            item = jfx4matlab.matlab.collections.map.MapItem('key', 'value');  
            
            assertEqual(testCase, item.getKey(), 'key'); 
            assertEqual(testCase, item.getValue(), 'value'); 
            assertEqual(testCase, item.getNext(), -1); 
        end
        
        function setKeyTest(testCase) 
            item = jfx4matlab.matlab.collections.map.MapItem('key', 'value');  
            
            item.setKey(42); 
            
            assertEqual(testCase, item.getKey(), 42);
        end
        
        function setValueTest(testCase) 
            item = jfx4matlab.matlab.collections.map.MapItem('key', 'value');  
            
            item.setValue(42); 
            
            assertEqual(testCase, item.getValue(), 42);
        end
        
        function setNextTest(testCase) 
            item = jfx4matlab.matlab.collections.map.MapItem('key', 'value');  
            
            item.setNext(42); 
            
            assertEqual(testCase, item.getNext(), 42);
        end
    end
end

