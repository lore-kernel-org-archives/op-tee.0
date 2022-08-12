From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/1] tee: Add tee_shm_register_fd
Date: Fri, 12 Aug 2022 19:31:38 +0530
Message-ID: 
 <CAFA6WYN6TdTR+O7UXe3D=5-5gRt5h7VhFYpGtyGGge-k3e_ShA@mail.gmail.com>
In-Reply-To: <20220811135637.6332-1-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4657705089836897976=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4657705089836897976==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Olivier,

On Thu, 11 Aug 2022 at 19:26, Olivier Masse <olivier.masse@nxp.com> wrote:
>
> Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> shared memory from a dmabuf file descriptor.
>

IIRC, here you are trying to fill the gap for OP-TEE SDP use-case. But
the use-case should be described here, its current status with OP-TEE
upstream and which platform you have tested this interface with?

-Sumit

> Etienne Carriere (1):
>   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
>
>  drivers/tee/tee_core.c   | 38 +++++++++++++++
>  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/tee_drv.h  | 11 +++++
>  include/uapi/linux/tee.h | 29 ++++++++++++
>  4 files changed, 175 insertions(+), 2 deletions(-)
>
> --
> 2.25.0
>

--===============4657705089836897976==--

