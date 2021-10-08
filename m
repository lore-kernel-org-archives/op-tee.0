From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
Date: Fri, 08 Oct 2021 21:21:46 +0200
Message-ID: <94277064-eff7-cd63-b5cb-d6b53e408e81@forissier.org>
In-Reply-To: <20211008163200.wgls7gijpsk556kl@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7817041631699079993=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7817041631699079993==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Sudeep,

On 10/8/21 6:32 PM, Sudeep Holla wrote:
> On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
>> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
>>> Adds support for using FF-A [1] as transport to the OP-TEE driver.
>>>
>>> Introduces struct optee_msg_param_fmem which carries all information
>>> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
>>> memory reference mapped by the hypervisor in S-EL2. Register usage is
>>> also updated to include the information needed.
>>>
>>> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
>>> enabled.
>>>
>>
>> I am not sure if I missed this with earlier version but I see the below
>> warning the second time I insert the optee module. I am sure I tested it
>> with previous version when I was fixing issues with FF-A as a module.
>>
>> Not sure if I am missing something in my steps.
>>
> 
> OK, more info, indeed I didn't observe this issue 2 weeks back with optee
> at commit 57e642f12085 ("core: enable system PTA upon user TA support").
> The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
> commit. Today I am testing the latest commit 2de2880065f3 ("core: update
> reference link to PrimeCell Cache Controller").
> 
> Though it looks like an issue with the driver, the latest optee changes
> triggered the driver to hit this issue in my setup. Hope this helps.

Totally makes sense. The optee_os commit triggering this is almost
certainly 811c42d40cd0 ("plat-vexpress: enable CFG_ENABLE_EMBEDDED_TESTS
by default"). With this commit, the "invoke tests" PTA gets included by
default in the TEE binary. This PTA has the TA_FLAG_DEVICE_ENUM flag so
it is enumerated by the Linux driver. AFAICT the vexpress platform has
no other PTA with that flag, so as you said the OP-TEE commit is simply
 exposing a bug in the Linux driver.

> IIUC we are not undoing optee_register_device executed via
> optee_enumerate_devices in the exit path.

That doesn't sound good indeed ;)

-- 
Jerome

--===============7817041631699079993==--

