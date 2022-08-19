From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Fri, 19 Aug 2022 13:54:31 +0530
Message-ID: 
 <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>
In-Reply-To: <20220812143055.12938-1-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3501985062384335888=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3501985062384335888==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Olivier,

On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com> wrote:
>
> Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> shared memory from a dmabuf file descriptor.
> This new ioctl will allow the Linux Kernel to register a buffer
> to be used by the Secure Data Path OPTEE OS feature.
>
> Please find more information here:
> https://static.linaro.org/connect/san19/presentations/san19-107.pdf
>
> Patch tested on Hikey 6220.
>

AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
heap driver for allocating secure buffers through exposed chardev:
"/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
as I can't find it upstream? Also, do you plan to push that upstream
as well?

BTW, please add a changelog while sending newer patch-set versions.

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

--===============3501985062384335888==--

