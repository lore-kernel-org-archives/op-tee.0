From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] introduction of a remoteproc tee to load signed
 firmware images
Date: Tue, 30 May 2023 10:20:48 -0600
Message-ID: <ZHYiYGMHdqxBaDzc@p14s>
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4060918675908171104=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4060918675908171104==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, May 23, 2023 at 11:13:46AM +0200, Arnaud Pouliquen wrote:
> This RFC proposes an implementation of a remoteproc tee driver to
> communicate with a TEE trusted application in charge of authenticating
> and loading remoteproc firmware image in an Arm secure context.
> 
> The services implemented are the same as those offered by the Linux
> remoteproc framework:
> - load of a signed firmware
> - start/stop of a coprocessor
> - get the resource table
> 
> 
> The OP-TEE code in charge of providing the service in a trusted application
> is proposed for upstream here:
> https://github.com/OP-TEE/optee_os/pull/6027
> 
> For more details on the implementation a presentation is available here:
> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
> 
> Arnaud Pouliquen (4):
>   tee: Re-enable vmalloc page support for shared memory
>   remoteproc: Add TEE support
>   dt-bindings: remoteproc: add compatibility for TEE support
>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> 
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  33 +-
>  drivers/remoteproc/Kconfig                    |   9 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/stm32_rproc.c              | 234 +++++++++--
>  drivers/remoteproc/tee_remoteproc.c           | 397 ++++++++++++++++++
>  drivers/tee/tee_shm.c                         |  24 +-
>  include/linux/tee_remoteproc.h                | 101 +++++
>  7 files changed, 753 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>  create mode 100644 include/linux/tee_remoteproc.h

Looking at comments from Christoph, there seems to be a good refactoring
exercise in store for this pathset.  As such I will wait for the next revision
to look at it.

Thanks,
Mathieu

> 
> -- 
> 2.25.1
> 

--===============4060918675908171104==--

