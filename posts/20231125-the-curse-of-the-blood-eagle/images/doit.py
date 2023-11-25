import os
import sys

fmt="""
<div class="clue">

<img src="./images/%s"></img>

</div>
"""
for img in os.listdir("."):
    print(fmt % img)
