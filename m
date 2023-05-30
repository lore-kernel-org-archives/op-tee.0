From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] introduction of a remoteproc tee to load signed
 firmware images
Date: Tue, 30 May 2023 17:12:58 +0000
Message-ID: <fc7fcb92-dec6-413a-7b08-1083a444f6fc@foss.st.com>
In-Reply-To: <ZHYiYGMHdqxBaDzc@p14s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1616539645494240505=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1616539645494240505==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Mathieu,

On 5/30/23 18:20, Mathieu Poirier wrote:
> On Tue, May 23, 2023 at 11:13:46AM +0200, Arnaud Pouliquen wrote:
>> This RFC proposes an implementation of a remoteproc tee driver to
>> communicate with a TEE trusted application in charge of authenticating
>> and loading remoteproc firmware image in an Arm secure context.
>>
>> The services implemented are the same as those offered by the Linux
>> remoteproc framework:
>> - load of a signed firmware
>> - start/stop of a coprocessor
>> - get the resource table
>>
>>
>> The OP-TEE code in charge of providing the service in a trusted application
>> is proposed for upstream here:
>> https://github.com/OP-TEE/optee_os/pull/6027
>>
>> For more details on the implementation a presentation is available here:
>> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
>>
>> Arnaud Pouliquen (4):
>>   tee: Re-enable vmalloc page support for shared memory
>>   remoteproc: Add TEE support
>>   dt-bindings: remoteproc: add compatibility for TEE support
>>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
>>
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  33 +-
>>  drivers/remoteproc/Kconfig                    |   9 +
>>  drivers/remoteproc/Makefile                   |   1 +
>>  drivers/remoteproc/stm32_rproc.c              | 234 +++++++++--
>>  drivers/remoteproc/tee_remoteproc.c           | 397 ++++++++++++++++++
>>  drivers/tee/tee_shm.c                         |  24 +-
>>  include/linux/tee_remoteproc.h                | 101 +++++
>>  7 files changed, 753 insertions(+), 46 deletions(-)
>>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>>  create mode 100644 include/linux/tee_remoteproc.h
> 
> Looking at comments from Christoph, there seems to be a good refactoring
> exercise in store for this pathset. 

Yes, a good opportunity to ramp-up on kernel memory management :)

As such I will wait for the next revision
> to look at it.

That's fair. More than that I would prefer to focus first on OP-TEE part that
provides the service. The OP-TEE pull request review could have significant
impacts on the kernel implementation...

Thanks,
Arnaud

> 
> Thanks,
> Mathieu
> 
>>
>> -- 
>> 2.25.1
>>

--===============1616539645494240505==--

