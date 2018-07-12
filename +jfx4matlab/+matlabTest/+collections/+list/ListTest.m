classdef ListTest < matlab.unittest.TestCase
    methods(Test)
        function isEmpty(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            
            assertTrue(testCase, list.isEmpty()); 
        end
        
        function size(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            
            assertEqual(testCase, list.size(), 0); 
        end
        
        function addTest1(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            
            assertFalse(testCase, list.isEmpty()); 
        end
        
        function addTest2(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            assertEqual(testCase, list.size(), 2); 
        end
        
        function addTest3(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            assertTrue(testCase, list.add(21)); 
        end
        
        function addTest4(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            assertFalse(testCase, list.add(11.5));
        end
        
        function removeTest1(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            list.remove(42); 
            
            assertEqual(testCase, list.size(), 1); 
        end
        
        function removeTest2(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            assertTrue(testCase, list.remove(21)); 
        end
        
         function removeTest3(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21); 
            
            assertFalse(testCase, list.remove(11.5)); 
         end
        
         function getTest1(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
            
            assertEqual(testCase, list.get(1), 42);
         end
         
         function getTest2(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
            
            assertEqual(testCase, list.get(2), 21);
         end
         
         function getTest3(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                        
            testCase.verifyError(@()list.get(3), 'EXCEPTION:IndexOutOfBounds');
         end
         
         function getTest4(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                        
            testCase.verifyError(@()list.get(0), 'EXCEPTION:IndexOutOfBounds');
         end
         
         function setTest1(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                   
            list.set(1, 11.5); 
            
            assertEqual(testCase, list.get(1), 11.5);
         end
         
         function setTest2(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                   
            list.set(2, 11.5); 
            
            assertEqual(testCase, list.get(2), 11.5);
         end
         
         function setTest3(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
            
            testCase.verifyError(@()list.set(3, 11.5), 'EXCEPTION:IndexOutOfBounds');
         end
         
         function setTest4(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                   
            assertEqual(testCase, list.set(2, 11.5), 21);
         end
         
         
         function setTest5(testCase) 
            list = jfx4matlab.matlab.collections.list.List();
            list.add(42); 
            list.add(21);
                   
            
            testCase.verifyError(@()list.set(0, 11.5), 'EXCEPTION:IndexOutOfBounds');
         end
    end
end

