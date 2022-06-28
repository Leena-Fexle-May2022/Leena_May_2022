public with sharing class Collections {
    public Collections() 
    {
        List<Integer> myList = new List<Integer>(); 
        myList.add(47);                   
        Integer i = myList.get(0);                  
        System.debug('value at 0th index: '+i);
        myList.set(0, 1);
        System.debug(mylist);
        myList.add(36);
        myList.add(78);
        System.debug('values before sorting: '+myList);
        myList.sort();
        System.debug('values after sorting: '+myList);
        myList.remove(36);
        System.debug('values after removing 36: '+myList);
        myList.clear();
        System.debug(mylist);

        Set<String> set1 = new Set<String>{'New York', 'Paris'};
        System.debug('string set: '+set1);
        Set<Integer> mySet = new Set<Integer>(); 
        mySet.add(1);
        mySet.add(3); 
        System.debug('values insert in integer set: '+myset);
        System.assert(mySet.contains(1));
        mySet.remove(1); 
        System.debug('values after removing 1: '+myset);
        System.debug('size of List: '+mySet);

        Map<Integer, String> m = new Map<Integer, String>(); 
        m.put(1, 'First entry');                
        m.put(2, 'Second entry'); 
        System.debug('map values: '+m);             
        System.assert(m.containsKey(1));
        String value = m.get(2);             
        System.assertEquals('Second entry', value);
        Set<Integer> s = m.keySet();  
        System.debug('set of keys:'+s);
        System.debug('values of map: '+m.values());    
    }
}