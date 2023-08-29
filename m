From: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Tue, 29 Aug 2023 22:17:36 +0530
Message-ID: <92ed14f5-d999-4d54-915b-0a3449da44f8@amd.com>
In-Reply-To: <0f16dd5a-bce7-0e36-3827-f713e90fb843@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7955159106044033159=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7955159106044033159==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 8/19/2023 4:34 AM, Randy Dunlap wrote:
> Hi--
>
> On 8/18/23 07:42, Devaraj Rangasamy wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
>> index 722b6eca2e93..5e38423f3d53 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -363,6 +363,13 @@
>>   			  selects a performance level in this range and appropriate
>>   			  to the current workload.
>>  =20
>> +	amdtee_cma=3Dnn	[HW,TEE]
>> +			Sets the memory size reserved for contiguous memory
>> +			allocations, to be used by amdtee device driver.
>> +			Value is in MB and can range from 4 to 128 (MBs)
> 			                                       128 (MBs).
Ack.
In updated patch, we dont use new custom kernel command line parameter,=20
and resorted to generic cma zone.
>
>> +			CMA will be active only when CMA is enabled, and amdtee is
> 	That could use some improvement. How about:
>
> 			AMD-TEE CMA will be active only when CONFIG_CMA is enabled,
> 			and amdtee is
Ack, as above.
>
>> +			built as inbuilt driver, and not loaded as module.
>> +
>>   	amijoy.map=3D	[HW,JOY] Amiga joystick support
>>   			Map of devices attached to JOY0DAT and JOY1DAT
>>   			Format: <a>,<b>
>> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
>> index 191f9715fa9a..5843c739a7b8 100644
>> --- a/drivers/tee/amdtee/Kconfig
>> +++ b/drivers/tee/amdtee/Kconfig
>> @@ -6,3 +6,12 @@ config AMDTEE
>>   	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>>   	help
>>   	  This implements AMD's Trusted Execution Environment (TEE) driver.
>> +
>> +config AMDTEE_CMA_SIZE
>> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
>> +	default "0"
> Why won't this default value cause an allocation error message?
> Maybe I'm just not following the call paths correctly.
>
> It looks to me like this causes a call to
> cma_declare_contiguous_nid() with @size =3D 0, and that function says:
>
> 	if (!size)
> 		return -EINVAL;
Ack.
It did resulted in error message. We have revoked new exclusive cma zone=20
now.
>> +	depends on CMA && (AMDTEE=3Dy)
>> +	help
>> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TE=
E driver
> 	                                                                          =
driver.
Ack.
>> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory =
from the CMA
> 	                                                                          =
       CMA.
Ack.
>> +	  The default can be overridden with the kernel commandline parameter "a=
mdtee_cma".
>> \ No newline at end of file
> Please fix that ^^^ warning.
Ack, as above. Thanks for the review.
>
> Thanks.

--===============7955159106044033159==--

