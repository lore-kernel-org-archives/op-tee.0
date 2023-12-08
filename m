From: Jonathan Corbet <corbet@lwn.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] Documentation: Destage TEE subsystem documentation
Date: Fri, 08 Dec 2023 15:52:11 -0700
Message-ID: <87fs0c489w.fsf@meer.lwn.net>
In-Reply-To: <20231128072352.866859-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1427107566990162435=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1427107566990162435==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Sumit Garg <sumit.garg@linaro.org> writes:

> Add a separate documentation directory for TEE subsystem since it is a
> standalone subsystem which already offers devices consumed by multiple
> different subsystem drivers.
>
> Split overall TEE subsystem documentation modularly where:
> - The userspace API has been moved to Documentation/userspace-api/tee.rst.
> - The driver API has been moved to Documentation/driver-api/tee.rst.
> - The first module covers the overview of TEE subsystem.
> - The further modules are dedicated to different TEE implementations like:
>   - OP-TEE
>   - AMD-TEE
>   - and so on for future TEE implementation support.
>
> Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> - Rebased to docs-next
> - Fixed dangling references to Documentation/staging/tee.rst.
> - Applied tags.

Applied, thanks.

jon

--===============1427107566990162435==--

