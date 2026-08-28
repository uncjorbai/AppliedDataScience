### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ 3190547f-e358-4c9b-8a29-320d354e6ab1
begin
	using LinearAlgebra
	# Example: Solutions to part (X) go here
	matrixA = [5 6 7
			   2 3 5
			   3 2 9]
	vectorb = [-1
			   0
			   9]
	matrixD = [1 2
			   2 -3
			   3 2]
	vectore = [4
			   1
			   8]
	x1 = matrixA \ vectorb
	print(x1)
	x2 = matrixD \ vectore
	print(x2)

		#validate?
	Dval = lu(matrixD)
	L = Dval.L
	println("L", L)
	U = Dval.U
	println("U", U)
	P = Matrix(Dval.P)
	println("P", P)

	approximate = isapprox(P* L * U, matrixD)
	println("Decomposition is equal?", approximate)

	#lu acting up on me

	LU = lu(matrixA)

	x3 = LU \ vectorb
	display(x3)

end

# ╔═╡ c674e9dc-0bbb-11ef-0719-d5b7ce34a3a8
md"
# DATA-750: HW 01 Introduction to Matrices and Operations

## Jordan Bailey
### Email: `jorbai@unc.edu`
"

# ╔═╡ 9b8d9fc8-6658-4c68-9279-2bc3cd61b05c
md"
In this first homework assignment you will be practicing some basic operations using the Julia programming language, and exploring some of the concepts discussed during Week 01 and Week 02 in the DATA 750 course. _Please use this sample template and structure as guidelines of the expected way to organize your work and solutions._

> Make sure to contact your instructor if there are any questions.
"

# ╔═╡ 4239b46b-60da-4f7b-84a9-1345456a01a0


# ╔═╡ 3418db22-454b-4cb7-8d79-4e70296ee2e7
md"
# Problem 1 (20 points)

(a) Define a variable `mycourse` with the name of this course as a string (use double quotes). 

(b) Use the `findall()` function, to count how many a's are in the name of the course.

(c) Define a 2x2 matrix $A$ with: 

- the month you were born in position $a_{11}$, 
- the day of the month you were born in position $a_{12}$, 
- the number of classes you are taking this term in position $a_{21}$, and 
- the day of the week this class meets in position $a_{22}$ (Assume the week starts on Sunday)

(d)  Multiply matrix $A$ from part (c) with its transpose. What can you say about the resulting matrix? 
"

# ╔═╡ bb6454b4-71ce-4367-8834-183915283970
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 03dbaae6-f851-408e-bad0-dd00c36d22d6
begin
	# Example: Solutions to part (X) go here
	mycourse = "Data 750"
	length(findall("a", mycourse))

	# Making a standard assumption that you cannot generate a matrix with text values 		properly
	#After attempting to run, I recant my earlier comment.
	#Can you make it? Yes. Is it pretty? No.
	#A = ["April" 10
	#		 2 "Tuesday"]

	A = [4 10
		 2 3] 
	display(A)

	C = A * A'
	display(C)
end

# ╔═╡ 69464c4a-5f10-45b5-b986-20f24bcec629


# ╔═╡ e1d5bd80-1eeb-47a6-9a24-7b68c44df97b
md"
# Problem 2 (30 points)

(a) Use the `rand()` function to generate a 5x7 matrix $B$ of random numbers. 

(b) Extract the matrix block that contains the entries between rows 2 and 4, and columns 3 and 5. 

(c) Create a random vector $u$ (of appropriate dimensions), and compute the matrix-vector multiplication $Bu$

(d)  Compute the product $(Bu)^T(Bu)$. What does this quantity represent? 
"

# ╔═╡ 78551271-91d4-4afa-ae9e-78c77c34b600
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 42823eef-089c-4ee4-ac34-4fd92ee12de7
begin
	# Example: Solutions to part (X) go here
	#B = rand(5,7)
	#I did not like the floats and some research yielded this result which I think is a lot easier to read and cleaner.
	B = rand(1:10, 5,7)

	Bblock = B[2:4, 3:5]
	
	uvector = rand(1:10, 7)

	Bu = B * uvector
	


	
	display(B)
	display(Bblock)
	display(uvector)
	display(Bu)
	print("Bu'*Bu is $(Bu'*Bu)")
	
end

# ╔═╡ a917a00a-1b88-4d21-8e3b-acc339bf3f94
md"
# Problem 3 (30 points)

(a) Define the matrix $A$ and vector $b$ below, and find the solution to the system of linear equations $Ax = b$  

$
A = \begin{bmatrix}
5 & 6 & 7 \\
2 & 3 & 5 \\
3 & 2 & 9
\end{bmatrix}, \quad b = \begin{bmatrix}
-1 \\
0  \\
9
\end{bmatrix}$


(b) Define the matrix $D$ and vector $e$ below, and find the solution to the system of linear equations $Dx = e$  

$
D = \begin{bmatrix}
1 & 2 \\
2 & -3 \\
3 & 2 
\end{bmatrix}, \quad e = \begin{bmatrix}
4 \\
1  \\
8
\end{bmatrix}$

Verify your solution.

(c) Solve part (a) using the $LU$ factorization of $A$.
"

# ╔═╡ 45d64003-7a99-489e-9db7-2fa14bb924dc
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ f22b089a-4c77-465b-aeb9-243b54f50554
md"
# Problem 4 (20 points)

(a) Consider the 2D rotation matrix below:

$
R = \begin{bmatrix}
\cos \theta & -\sin \theta \\  
\sin \theta & \cos \theta 
\end{bmatrix}$

Define a value of $\theta$ and a sample vector $w$. Compute $Rw$. 



(b) How can you confirm that the result obtained in part (a) is correct? 
"

# ╔═╡ 5c14b6ea-e93e-4a1a-9d6a-21bfb66dbbd9
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 2913e0b9-a33a-4a49-90a4-0aa63d8a8455
begin
	# Example: Solutions to part (X) go here
	theta = pi/2
	w = [5,10]
	
	R = [cos(theta) -sin(theta)
		 sin(theta) cos(theta)]
	
	
	Rw = R * w
	display(Rw)

	mag1 = norm(w)
	display(mag1)
	mag2 = norm(Rw)
	display(mag2)
	deno = mag2 * mag1'
	display(deno)
	
	cosine = (w' * Rw) / deno

	
	print("Cosine = $cosine")	

	notthecosine = acos(cosine)
	print("Arccos = $notthecosine")
	#pivalue = notthecosine * 2
	#display(pivalue)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.5"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─c674e9dc-0bbb-11ef-0719-d5b7ce34a3a8
# ╟─9b8d9fc8-6658-4c68-9279-2bc3cd61b05c
# ╠═4239b46b-60da-4f7b-84a9-1345456a01a0
# ╟─3418db22-454b-4cb7-8d79-4e70296ee2e7
# ╟─bb6454b4-71ce-4367-8834-183915283970
# ╠═03dbaae6-f851-408e-bad0-dd00c36d22d6
# ╠═69464c4a-5f10-45b5-b986-20f24bcec629
# ╟─e1d5bd80-1eeb-47a6-9a24-7b68c44df97b
# ╟─78551271-91d4-4afa-ae9e-78c77c34b600
# ╠═42823eef-089c-4ee4-ac34-4fd92ee12de7
# ╟─a917a00a-1b88-4d21-8e3b-acc339bf3f94
# ╟─45d64003-7a99-489e-9db7-2fa14bb924dc
# ╠═3190547f-e358-4c9b-8a29-320d354e6ab1
# ╟─f22b089a-4c77-465b-aeb9-243b54f50554
# ╟─5c14b6ea-e93e-4a1a-9d6a-21bfb66dbbd9
# ╠═2913e0b9-a33a-4a49-90a4-0aa63d8a8455
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
