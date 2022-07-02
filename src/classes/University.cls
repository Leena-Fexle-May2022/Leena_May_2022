public virtual class University {
    String universityName;
    String universityAddress;
    public University(String name, String address) {
        universityName=name;
        universityAddress=address;
    }
    public virtual class College{
        String name;
        String address;
        University university1;
        public College(String name, String address, String name2, String address2){
            this.name=name;
            this.address=address;
            university1 = new University(name2, address2);
        }
        public virtual void display()
        {
            System.debug('name of college : '+name);
            System.debug('Address of college : '+address);
            university1.display();
        }
    }
    public void display()
    {
        System.debug('name of University : '+universityName);
        System.debug('Address of University : '+ universityAddress);
    }
}