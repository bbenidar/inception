


#include <iostream>
#include <vector>
#include <map>

using namespace std;

void add_to_nums(vector<int> &nums)
{
    nums.push_back(1);
    nums.push_back(1);
    nums.push_back(1);
    nums.push_back(2);
    nums.push_back(2);
    nums.push_back(2);
    nums.push_back(2);
    nums.push_back(2);
    nums.push_back(3);
}


int main()
{
    vector<int> nums;
    add_to_nums(nums);
    vector<int> cpy;
        map <int, int> mp;
        int max = 0;
        for (int i : nums)
        {
            if (mp.count(i))
                mp[i]++;
            else
                mp[i] = 1;
            if (mp[i] > max)
                max = mp[i];
        }
        //print the map
        cout << "the max is: " << mp.count(max) << endl;
        // get the key of the biggest value
        cout << "[ ";
        for (auto i : mp)
        {
            cout << i.first << " : " << i.second << ", ";
        }
        // get the biggest value

}