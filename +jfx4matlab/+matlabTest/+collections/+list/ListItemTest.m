classdef ListItemTest < matlab.unittest.TestCase
    properties
    end
 
    methods(TestMethodSetup)
    end
 
    methods(TestMethodTeardown)
    end
 
    methods(Test)
        function initTest(testCase) 
            listItem = jfx4matlab.matlab.collections.list.ListItem(42);
            
            assertEqual(testCase, listItem.getValue(), 42); 
            assertEqual(testCase, listItem.getNext(), -1); 
        end
        
        function setValueTest(testCase) 
            listItem = jfx4matlab.matlab.collections.list.ListItem(42);
            
            listItem.setValue(21); 
            
            assertEqual(testCase, listItem.getValue(), 21); 
        end
        
        function setNextTest(testCase) 
            listItem = jfx4matlab.matlab.collections.list.ListItem(42);
            
            listItem.setNext(42); 
            
            assertEqual(testCase, listItem.getNext(), 42); 
        end
        
        function childCountTest1(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            
            assertEqual(testCase, item.childCount, 0); 
            
        end
        
        function childCountTest2(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            nextItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(nextItem); 
            
            assertEqual(testCase, item.childCount, 1); 
        end
        
        function childCountTest3(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            secondItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(secondItem);
            thirdItem = jfx4matlab.matlab.collections.list.ListItem(11.5); 
            secondItem.setNext(thirdItem); 
            
            assertEqual(testCase, item.childCount, 2); 
        end
        
        function getTest1(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            secondItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(secondItem);
            thirdItem = jfx4matlab.matlab.collections.list.ListItem(11.5); 
            secondItem.setNext(thirdItem); 
            
            assertEqual(testCase, item.get(1), 21);
        end
        
        function getTest2(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            secondItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(secondItem);
            thirdItem = jfx4matlab.matlab.collections.list.ListItem(11.5); 
            secondItem.setNext(thirdItem); 
            
            testCase.verifyError(@()item.get(3), 'EXCEPTION:IndexOutOfBounds');
        end
        
        function setTest1(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            secondItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(secondItem);
            thirdItem = jfx4matlab.matlab.collections.list.ListItem(11.5); 
            secondItem.setNext(thirdItem); 
            
            item.set(1, 22); 
            
            assertEqual(testCase, item.get(1), 22);
        end
        
        function setTest2(testCase) 
            item = jfx4matlab.matlab.collections.list.ListItem(42); 
            secondItem = jfx4matlab.matlab.collections.list.ListItem(21); 
            item.setNext(secondItem);
            thirdItem = jfx4matlab.matlab.collections.list.ListItem(11.5); 
            secondItem.setNext(thirdItem); 
            
            testCase.verifyError(@()item.set(3, 22), 'EXCEPTION:IndexOutOfBounds');
        end
    end
end

