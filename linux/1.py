
from typing import Optional

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution:
    def middleNode(self, head: Optional[ListNode]) -> Optional[ListNode]:
        import math
        llist = []
        next = head
        while next:
            llist.append(next)
            next = next.next
        return llist[len(llist)//2]




lL = []
for i in range(6):
    i+=1
    new = ListNode(i)
    if len(lL) > 0:
        lL[i-1].next = new
    lL.append(new)
    


a = Solution()
print(a.middleNode(lL[0]).val)