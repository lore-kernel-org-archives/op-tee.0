From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Tue, 22 Aug 2023 18:43:44 +0000
Message-ID: <184a97f5-1ad1-6efc-bc7b-b41fce6f2773@linux.microsoft.com>
In-Reply-To: <7c8945be-2549-ee79-fbdf-4870eca6f908@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7356748325200876118=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7356748325200876118==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Bart,

sorry for not replying earlier, as I am very new to NVMe/UFS spec and was=20
figuring out few details about them.

> On 7/21/23 18:40, Shyam Saini wrote:
>>  +config RPMB
>>  +	tristate "RPMB partition interface"
>>  +	help
>>  +	  Unified RPMB partition interface for RPMB capable devices such as
>>  +          eMMC and UFS. Provides interface for in kernel security
>>  controllers to
>>  +	  access RPMB partition.
>>  +
>>  +	  If unsure, select N.
>
> Please also mention NVMe.

Sure,
> Please change the word "partition" into "unit" to avoid confusion with the =

> concept "LBA range partition".

sure, in next iteration

>>  +static DEFINE_IDA(rpmb_ida);
>
> How are accesses to this IDA serialized?

I will look into that.

>>  +/**
>>  + * rpmb_get_capacity() - returns the capacity of the rpmb device
>>  + * @rdev: rpmb device
>>  + *
>>  + * Return:
>>  + * *        capacity of the device in units of 128K, on success
>>  + * *        -EINVAL on wrong parameters
>>  + * *        -EOPNOTSUPP if device doesn't support the requested operation
>>  + * *        < 0 if the operation fails
>>  + */
>
> Why in units of 128 KiB?

I think UFS/eMMC RPMB spec suggests size of RPMB multiple of 128K
and NVMe spec suggests RPMB Data Area to be multiple of 128K as well.

>>  +/**
>>  + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent
>>  device
>>  + * @parent: parent device of the rpmb device
>>  + * @target: RPMB target/region within the physical device
>>  + *
>>  + * Return: NULL if there is no rpmb device associated with the parent
>>  device
>>  + */
>
> Can an NVMe controller have multiple RPMB units? From the NVMe specificatio=
n:=20
> "The controller may support multiple RPMB targets."

That we have to figure, I see NVMe device can have upto 7 RPMB
targets/units

> Can rpmb_dev_find_by_device() be used if multiple RPMB units are associated=
=20
> with a single controller?

That's not finalised yet, but we some ideas from Optee folks on the other=20
replies.

>>  +/**
>>  + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
>>  + * @dev: storage device of the rpmb device
>>  + * @target: RPMB target/region within the physical device
>>  + * @ops: device specific operations
>>  + *
>>  + * Return: a pointer to rpmb device
>>  + */
>>  +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
>>  +				   const struct rpmb_ops *ops)
>>  +{
>>  +	struct rpmb_dev *rdev;
>>  +	int id;
>>  +	int ret;
>>  +
>>  +	if (!dev || !ops)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->program_key)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->get_capacity)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->get_write_counter)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->write_blocks)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	if (!ops->read_blocks)
>>  +		return ERR_PTR(-EINVAL);
>>  +
>>  +	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
>>  +	if (!rdev)
>>  +		return ERR_PTR(-ENOMEM);
>>  +
>>  +	id =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
>>  +	if (id < 0) {
>>  +		ret =3D id;
>>  +		goto exit;
>>  +	}
>>  +
>>  +	mutex_init(&rdev->lock);
>>  +	rdev->ops =3D ops;
>>  +	rdev->id =3D id;
>>  +	rdev->target =3D target;
>>  +
>>  +	dev_set_name(&rdev->dev, "rpmb%d", id);
>>  +	rdev->dev.class =3D &rpmb_class;
>>  +	rdev->dev.parent =3D dev;
>>  +
>>  +	rpmb_cdev_prepare(rdev);
>>  +
>>  +	ret =3D device_register(&rdev->dev);
>>  +	if (ret)
>>  +		goto exit;
>>  +
>>  +	rpmb_cdev_add(rdev);
>>  +
>>  +	dev_dbg(&rdev->dev, "registered device\n");
>>  +
>>  +	return rdev;
>>  +
>>  +exit:
>>  +	if (id >=3D 0)
>>  +		ida_simple_remove(&rpmb_ida, id);
>>  +	kfree(rdev);
>>  +	return ERR_PTR(ret);
>>  +}
>
> How is user space software supposed to map an NVMe RPMB target ID to an RPM=
B=20
> device name?

I am not sure, this driver aims to provide in kernel RPMB access APIs,=20
user space support may be added later on, but i will look if the current=20
RFC version has any implication on future user-space support.

>>  +MODULE_AUTHOR("Intel Corporation");
>
> Shouldn't this be the name of a person instead of the name of a company?
>

Thanks, I will address that in next iteration.

Please keep posted your reviews and feedback.

Best Regards,
Shyam

--===============7356748325200876118==--

