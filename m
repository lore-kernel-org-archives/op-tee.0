From: Jonathan Corbet <corbet@lwn.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
Date: Mon, 27 Nov 2023 10:52:04 -0700
Message-ID: <87h6l7yth7.fsf@meer.lwn.net>
In-Reply-To: <20231103061715.196294-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6919234722775007020=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6919234722775007020==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Move userspace API to Documentation/userspace-api/tee.rst.
> - Move driver API to Documentation/driver-api/tee.rst.
>
>  Documentation/driver-api/index.rst    |   1 +
>  Documentation/driver-api/tee.rst      |  66 +++++
>  Documentation/staging/index.rst       |   1 -
>  Documentation/staging/tee.rst         | 364 --------------------------
>  Documentation/subsystem-apis.rst      |   1 +
>  Documentation/tee/amd-tee.rst         |  90 +++++++
>  Documentation/tee/index.rst           |  19 ++
>  Documentation/tee/op-tee.rst          | 166 ++++++++++++
>  Documentation/tee/tee.rst             |  22 ++
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/tee.rst   |  39 +++
>  MAINTAINERS                           |   4 +-
>  12 files changed, 408 insertions(+), 366 deletions(-)
>  create mode 100644 Documentation/driver-api/tee.rst
>  delete mode 100644 Documentation/staging/tee.rst
>  create mode 100644 Documentation/tee/amd-tee.rst
>  create mode 100644 Documentation/tee/index.rst
>  create mode 100644 Documentation/tee/op-tee.rst
>  create mode 100644 Documentation/tee/tee.rst
>  create mode 100644 Documentation/userspace-api/tee.rst

So I finally got around to applying this...after dealing with the fact
that it doesn't apply to docs-next, I found that it adds a couple of
warnings:

> Warning: Documentation/security/keys/trusted-encrypted.rst references a fil=
e that doesn't exist: Documentation/staging/tee.rst
> Warning: drivers/tee/optee/Kconfig references a file that doesn't exist: Do=
cumentation/staging/tee.rst

Can I get a version that doesn't leave dangling references like that
around?

Thanks,

jon

--===============6919234722775007020==--

