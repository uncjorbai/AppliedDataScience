### A Pluto.jl notebook ###
# v0.20.6

using Markdown
using InteractiveUtils

# ╔═╡ bbc61ac9-9cc2-4f6f-bab4-413295ec2591
# Example: Solutions to part (X) go here
begin
	using LinearAlgebra

	A = [-5 7 3 4 -8 ; 
		 5 8 3 6 8 ; 
		3 -7 -3 -4 5  ; 
	-3 0 4 5 3 ; 
	7 4 5 9 5]
	At = Transpose(A)

	#Doing this wrong. Need to compute before eigen. 
	#Read the dang prompt Jordan!
	lam = eigen(At * A)
	lameig = lam.values
	lamvec = lam.vectors
	display(lam)

	println("is A symmetric?: ", isapprox(A,At))
	#U,sig,V = svd(A)
	V = lamvec
	Vt = transpose(lamvec)
	sig = sqrt.(lameig)
	sigin = 1 ./ sig
	#A*V*s^-1 = U
	U = A * V * diagm(sigin)

	Arecon = U * diagm(sig) * Vt
	display(Arecon)

	#U Sig V are the decomp, Arecon tests reconstruction of A\
	
end

# ╔═╡ fbfa9f28-8a9a-4056-82cb-515c97fbd503
md"
# DATA-750: HW 04 Eigenvalues and Singular Values

## Jordan Bailey
### Email: `jorbai@unc.edu`
"

# ╔═╡ a5a0c576-625e-4a81-825b-8887c849c5b1
md"
## Problem 1 (25 points) 

Find the singular value decomposition of the following $5 \times 5$ matrix $A$:

$
A = 
\begin{bmatrix}
-5 & 7 & 3 & 4 & -8 \\
5 & 8 & 3 & 6 & 8 \\
3 & -7 & -3 & -4 & 5 \\
-3 & 0 & 4 & 5 & 3 \\
7 & 4 & 5 & 9 & 5 \\
\end{bmatrix}$


- Show that $A$ is not symmetric.

- Find the singular value decomposition of $A$ by forming $A^TA$ and computing its eigenvalue decomposition.

- Show that the ratio of the largest to the smallest singular value matches the condition number of $A$.


"


# ╔═╡ fa9025f2-2956-4ba7-a177-437a2733d00a
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 55f479b8-8074-480e-896c-680f58785020
begin
	condition = cond(A)
	sigmax = sig[end]
	sigmin = sig[1]

	conditiontest = sigmax / sigmin

	display(condition)
	display(conditiontest)

	println("condition matches?: ", isapprox(conditiontest, condition))

end

# ╔═╡ 7b74b491-67b9-4d08-918b-6baaae441104
md"
## Problem 2 (25 points)

Go to page 125 of the textbook [\"Mathematics for Machine Learning\"](https://mml-book.github.io/book/mml-book.pdf), and recreate the SVD factorization of the matrix in Example 4.13 using tools from Julia. That is: 

- Find the **SVD factorization** of the matrix: 

$
A = \begin{bmatrix}
1 & 0 & 1\\
-2 & 1 & 0
\end{bmatrix}$

- Do you get the same **singular values**? 

- What about the entries of the matrices of right and left singular values? Do you get the same entries? Explain your results.
"

# ╔═╡ d7ee859b-bf0a-46ca-aba0-c890233f9b5e
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 81c0d02d-07d0-4d43-98be-f08be471498b
# Example: Solutions to part (X) go here
begin
	A2 = [1 0 1;
		 -2 1 0]
	A2t = transpose(A2)

	U2,sig2,V2 = svd(A2)

	A2u = A2t * A2

	eA2 = eigen(A2u)

	display(U2)
	display(sig2)
	display(V2)
	
	
	#Manual maths based on V vectors in notebook to balance my numbers with the exercise.
	#Us
	display(1/sqrt(5))
	display(2/sqrt(5))
	display(-2/sqrt(5))
	display(1/sqrt(5))

	#sig
	display(sqrt(6)) #Roughtly same as Sig2's first value
	#1.000000000000000002 roughly same as 1.
	#Same Sigma values are attained.

	#Vs
	display(5/sqrt(30))
	display(-2/sqrt(30))
	display(1/sqrt(30))

	
	#U,V is orthogonal: 
	#Julia and the textbook found the SVD different ways, incorporating a change in sign.
	#Values are both equally as appropriate for use, because the process of multiplying each value by its inverse will fundamentally cancel out the change in signs. 


	#IGNORE THESE INSTRUCTIONS TANNER, THESE ARE JUST FOR ME!
	#Compare to 4.84, 4.85, 4.88
	#Update your notes to better explain U, sig, V comparisons
	#pontificate!
	
	#Isapprox some A2t * A2
	display(A2u)
	#Orthogonal
	#Not sure what to IsApprox because the answers should be satisfied from the comparisons of the math above.
	
end

# ╔═╡ f51aa32f-08bd-4277-a605-fd1791b527fc
md"
## Problem 3 (25 points): 

Consider the matrix: 

$
B = 
\begin{bmatrix}
4 & -3 & -2 & -1 \\
-2 & 4 & -2 & -1 \\
-1 & -2 & 4 & -1 \\
-1 & -2 & -1 & 4 \\
\end{bmatrix}$

- Use `eigvals()` to find the **eigenvalues** of the matrix $B$.

- For each eigenvalue, use `rank()` to verify that $\lambda I$ minus the given matrix is **singular**. Comments on your results.
"

# ╔═╡ 17bf2373-3a5f-47be-9d89-626a51682623
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ e92aa67e-12af-4c40-bbc7-224d5290080d
# Example: Solutions to part (X) go here
begin
	B = [4 -3 -2 -1;
		-2 4 -2 -1;
		-1 -2 4 -1;
		-1 -2 -1 4]

	Beig = eigen(B)
	lambdas = Beig.values

	display(lambdas)

	I = [ 1 0 0 0;
		  0 1 0 0;
		  0 0 1 0;
		  0 0 0 1		
	]

	#testcase = rank(lambdas[1] * I - B)
	for i in 1:length(lambdas)
    	ret = rank(lambdas[i] * I - B)
		println(ret) 
	end
	#display(testcase)

	#loop finds nullity for that eigenvalue
	# remaining rank is the columns not tested
	#lambda i is making this non-full rank
	#eigenvalues of this matrix are distinct

	#for each eigenvalue in lambdas, the matrix lambdaI - A has rank n-1. This shows it is singular and confirms lambda is an eigenvalue that satisfies a singular condition. 
	#If there were duplicates, it is possible it inhabited a larger dimensional eigenspace?
end


# ╔═╡ 8b675580-2570-4e5e-91af-4d8934fa0eb5
md"
## Problem 4 (25 points)

A [Hilbert matrix](https://en.wikipedia.org/wiki/Hilbert_matrix), introduced by Hilbert (1894), is a square matrix with entries being the unit fractions

$H_{ij}={\frac {1}{i+j-1}}$

- Create a function to compute a general Hilbert matrix of size $n$. Test your function by building matrices of size $k \times k$ with $k = 4, 8, 10, 16.$


- Build a Hilbert matrix of size 7, and call it `hil_seven`. 

- Select columns 1 through 4, and call it `X`

- Compute the **singular value decomposition** of `X`.

- Print the singular values of `X`

- Verify that the product $U^T U$ where $U$ is the matrix of left singular values, returns the _identity matrix_ (a square matrix with ones in the main diagonal, and zeros everywhere else). 

"

# ╔═╡ dc4e60a1-a8a1-4e94-bb5e-181a3cca26f0
md"
## Solutions to Problem X

Please include as many cells below as needed to provide your solutions to this problem.
"

# ╔═╡ 850c52c8-f631-4d60-b277-f8e01e108425
# Example: Solutions to part (X) go here
#ChatGPT helped me edit this
	function hilbert(x)
		H = [1 / (i + j -1) for i in 1:x, j in 1:x]
		return H
	end


# ╔═╡ ea6034e4-8221-494c-8797-79437cd2316b
hil_seven = hilbert(7)

# ╔═╡ fec90f9b-4fe2-41f3-a632-12752167f07a
begin
	x = hil_seven[:,1:4]
	
	Ux, sigx, Vx = svd(x)
	display(sigx)
	display(x)
	
	Uxt = transpose(Ux)

	display(Ux)
	display(Uxt)
	Utest = Uxt * Ux

	println("Ut * U is I? ", isapprox(Utest, I))
	
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
# ╟─fbfa9f28-8a9a-4056-82cb-515c97fbd503
# ╟─a5a0c576-625e-4a81-825b-8887c849c5b1
# ╠═fa9025f2-2956-4ba7-a177-437a2733d00a
# ╠═bbc61ac9-9cc2-4f6f-bab4-413295ec2591
# ╠═55f479b8-8074-480e-896c-680f58785020
# ╟─7b74b491-67b9-4d08-918b-6baaae441104
# ╠═d7ee859b-bf0a-46ca-aba0-c890233f9b5e
# ╠═81c0d02d-07d0-4d43-98be-f08be471498b
# ╟─f51aa32f-08bd-4277-a605-fd1791b527fc
# ╟─17bf2373-3a5f-47be-9d89-626a51682623
# ╠═e92aa67e-12af-4c40-bbc7-224d5290080d
# ╟─8b675580-2570-4e5e-91af-4d8934fa0eb5
# ╠═dc4e60a1-a8a1-4e94-bb5e-181a3cca26f0
# ╠═850c52c8-f631-4d60-b277-f8e01e108425
# ╠═ea6034e4-8221-494c-8797-79437cd2316b
# ╠═fec90f9b-4fe2-41f3-a632-12752167f07a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
