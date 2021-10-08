From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
Date: Fri, 08 Oct 2021 17:32:00 +0100
Message-ID: <20211008163200.wgls7gijpsk556kl@bogus>
In-Reply-To: <20211008132732.hbmkd3hftdydtrsc@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1559355489904503375=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1559355489904503375==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Oct 08, 2021 at 02:27:32PM +0100, Sudeep Holla wrote:
> On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
> > Adds support for using FF-A [1] as transport to the OP-TEE driver.
> >
> > Introduces struct optee_msg_param_fmem which carries all information
> > needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > memory reference mapped by the hypervisor in S-EL2. Register usage is
> > also updated to include the information needed.
> >
> > The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > enabled.
> >
> 
> I am not sure if I missed this with earlier version but I see the below
> warning the second time I insert the optee module. I am sure I tested it
> with previous version when I was fixing issues with FF-A as a module.
> 
> Not sure if I am missing something in my steps.
>

OK, more info, indeed I didn't observe this issue 2 weeks back with optee
at commit 57e642f12085 ("core: enable system PTA upon user TA support").
The UUID(d96a5b40-c3e5-21e3-8794-1002a5d5c61b) wasn't enumerated with above
commit. Today I am testing the latest commit 2de2880065f3 ("core: update
reference link to PrimeCell Cache Controller").

Though it looks like an issue with the driver, the latest optee changes
triggered the driver to hit this issue in my setup. Hope this helps.
IIUC we are not undoing optee_register_device executed via
optee_enumerate_devices in the exit path.

--
Regards,
Sudeep

--===============1559355489904503375==--

