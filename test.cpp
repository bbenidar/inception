


#include <iostream>
#include <vector>
#include <map>

using namespace std;

void add_to_nums(vector<int> &nums)
{
    nums.push_back(100);
    // nums.push_back(0);
    // nums.push_back(1);
}


int main()
{
    vector<int> c;
    add_to_nums(c);

        int j = c.size();
        cout << j << endl;
        int r =0;
        sort(c.begin(), c.end());
           for(int f = 0;  f < c.size(); f++)
           {
                if ((j + 1) - (f + 1) >= f)
                    r = f + 1;
           }
        cout << r << endl;

}