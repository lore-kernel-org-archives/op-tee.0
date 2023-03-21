From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Boot arguments for S-EL1 with SPMC at S-EL2
Date: Tue, 21 Mar 2023 09:30:32 +0100
Message-ID: 
 <CAHUa44H9sMP9xC7zf_jCXQymgPhWjgM=Wd0csbtjkwb0Cy6BPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4468210533886209010=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4468210533886209010==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Olivier,

I'm trying to implement a relocatable OP-TEE binary so it can be
loaded at different physical addresses without the need to recompile
it. This means that in the case with Hafnium when changing
"load-address" or "entrypoint-offset" in the OP-TEE SP manifest
there's no need to recompile OP-TEE. For this to work OP-TEE must be
able to figure out which memory range it's supposed to reside in.
Currently, OP-TEE knows the entry point address from PC and "memory
size" from X0. However, the "memory size" is from the "load-address"
so "entrypoint-offset" must be subtracted from PC in order to know the
allocated memory range.

Do you have ideas on how OP-TEE at runtime can determine the allocated
memory range?

Thanks,
Jens

--===============4468210533886209010==--

