# c  = get_config()

# c.TerminalIPythonApp.display_banner = True
# c.InteractiveShell.autoindent = True
# c.InteractiveShell.deep_reload = True
# c.PromptManager.in_template  = '>> '
# c.PromptManager.in2_template = '   .\D.: '
# c.PromptManager.out_template = ' '
# c.PromptManager.justify = True

# c.InteractiveShellApp.exec_lines = [
#     'import numpy',
#     'import sympy as sy',
#     'from sympy import diff, expand, simplify'
#     'from sympy.abc import x, y, z, w'
# ]


import numpy
import sympy as sy
from sympy import diff, expand, simplify, pprint
from sympy import sin, cos, tan, exp, log, atan, sqrt
from sympy.abc import x, y, z, w


sy.init_printing()

print("\n [INFO] SymPy => Symbolic Engine Loaded Ok \n")
