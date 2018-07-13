classdef MapTest < matlab.unittest.TestCase
    methods(Test)
        function initTest(testCase) 
            map = jfx4matlab.matlab.collections.map.Map(); 
            
            assertEqual(testCase, map.getValues().size(), 0); 
        end
        
        function putTest1(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            
            assertFalse(testCase, map.put(21, 42)); 
        end
        
        function putTest2(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            
            assertTrue(testCase, map.put(21, 42)); 
        end
        
        function putTest3(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            assertTrue(testCase, map.containsKey(23)); 
        end
        
        function getTest1(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            testCase.verifyError(@()map.get(-1), 'EXCEPTION:IllegalArgument');
        end
        
        function getTest2(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 21);
            
            assertEqual(testCase, map.get(23), 21); 
        end
        
        function removeTest1(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            assertFalse(testCase, map.remove(-1));
        end
        
        function removeTest2(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            assertTrue(testCase, map.remove(23));
            assertFalse(testCase, map.containsKey(23)); 
        end
        
        function removeTest3(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            assertTrue(testCase, map.remove(21));
            assertFalse(testCase, map.containsKey(21)); 
        end
        
        function containsKeyTest(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 42);
            map.put(23, 42);
            
            assertFalse(testCase, map.containsKey(24)); 
        end
        
        function getValuesTest(testCase) 
            map = jfx4matlab.matlab.collections.map.Map();
            map.put(21, 42);
            map.put(22, 43);
            map.put(23, 44);
            
            assertEqual(testCase, map.getValues().size(), 3);
        end
    end
end

