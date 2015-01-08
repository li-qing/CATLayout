# CATLayout
Objective-C Auto Layout Constraint Builder with Chaining Pattern


## Why do We Need a Constraint Builder ?

It's simply because that we will never like the codes below:

	[NSLayoutConstraint constraintWithItem:fromItem
								 attribute:fromAttribute
							     relatedBy:relation
									toItem:toItem
								 attribute:toAttribute
								multiplier:multiplier
							      constant:constant]


## Builder and Syntax

1\. **CATLayout** from *-[UIView cat_layout]*

	syntax: <#from attribute#>.<#relation#>.<#multiplier#>.<#to attribute of view#>.<#constant#>

	example: view.cat_layout.width.equal.multiply(0.5f).widthOf(container).constant(8)

2\. **CATPin** from *-[UIView cat_pin]*

	syntax: <#width or height#>.<#relation#>.<#multiplier#>.<#to/than view#>.<#constant#>

	example: view.cat_pin.height.to(container).constant(-16)

3\. **CATAlign** from *-[UIView cat_align]*

	syntax: <#attribute#>.<#relation#>.<#to/than view#>.<#constant#>

	example: view.cat_align.left.to(container).constant(8)

Much like natural language, isn't it?


## Other Features

### Easy to Create and Add the Constraint

All these builder classes support 3 ways to build the constraint:

1\. - (NSLayoutConstraint *)constraint;

	create and return the constraint

2\. - (NSLayoutConstraint *)setInView:(UIView *)container;

	create and add the constraint to container view

3\. - (NSLayoutConstraint *)set;

	create and add the constraint to the nearest common ancestor of fromView and toView

### Copying and Reverse Supported

You could use **-reverse** method to avoid some constraint conflict.

- - -

### Check out the project to run the demo. Keep constraints simple. Have fun!
