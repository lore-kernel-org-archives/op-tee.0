From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Wed, 16 Aug 2023 16:31:59 -0700
Message-ID: <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com>
In-Reply-To: <
 <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3195800137800195423=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3195800137800195423==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Ulf,

> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> <shyamsaini@linux.microsoft.com> wrote:
>>
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>> originally proposed by [2]Thomas Winkler ]
>>
>> A number of storage technologies support a specialised hardware
>> partition designed to be resistant to replay attacks. The underlying
>> HW protocols differ but the operations are common. The RPMB partition
>> cannot be accessed via standard block layer, but by a set of specific
>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>> partition provides authenticated and replay protected access, hence
>> suitable as a secure storage.
>>
>> The initial aim of this patch is to provide a simple RPMB Driver which
>> can be accessed by Linux's optee driver to facilitate fast-path for
>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>
>> A TEE device driver can claim the RPMB interface, for example, via
>> class_interface_register(). The RPMB driver provides a series of
>> operations for interacting with the device.
>
> I don't quite follow this. More exactly, how will the TEE driver know
> what RPMB device it should use?

I don't have complete code to for this yet, but i think OP-TEE driver
should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
specific implementation for RPMB operations.

Linux optee driver can handle RPMB frames and pass it to RPMB subsystem

[1] U-Boot has mmc specific implementation

I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb, but in case if a
system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
should be declared as secure storage and optee should access that one=20
only.

Sumit, do you have suggestions for this ?


>>
>>   * program_key - a one time operation for setting up a new device
>>   * get_capacity - introspect the device capacity
>>   * get_write_counter - check the write counter
>>   * write_blocks - write a series of blocks to the RPMB device
>>   * read_blocks - read a series of blocks from the RPMB device
>>
>> The detailed operation of implementing the access is left to the TEE
>> device driver itself.
>>
>> The framing details and HW specific bits (JDEC vs NVME frames) are
>> left to the lower level TEE driver to worry about.
>>
>> Without kernel fast path to RPMB access doesn't work when IMA try to
>> extend ftpm's PCR registers.
>>
>> This fast-path would require additional work in linux optee driver and
>> as well as in MMC driver.
>>
>> [1] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee(a)li=
naro.org/
>> [2] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tom=
as.winkler(a)intel.com/
>> [3] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
>>
>
> [...]
>
>> +/**
>> + * rpmb_dev_find_device() - return first matching rpmb device
>> + * @data: data for the match function
>> + * @match: the matching function
>> + *
>> + * Return: matching rpmb device or NULL on failure
>> + */
>> +static
>> +struct rpmb_dev *rpmb_dev_find_device(const void *data,
>> +                                     int (*match)(struct device *dev,
>> +                                                  const void *data))
>> +{
>> +       struct device *dev;
>> +
>> +       dev =3D class_find_device(&rpmb_class, NULL, data, match);
>> +
>> +       return dev ? to_rpmb_dev(dev) : NULL;
>> +}
>> +
>> +struct device_with_target {
>> +       const struct device *dev;
>> +       u8 target;
>> +};
>> +
>> +static int match_by_parent(struct device *dev, const void *data)
>> +{
>> +       const struct device_with_target *d =3D data;
>> +       struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
>> +
>> +       return (d->dev && dev->parent =3D=3D d->dev && rdev->target =3D=3D=
 d->target);
>> +}
>> +
>> +/**
>> + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
>> + * @parent: parent device of the rpmb device
>> + * @target: RPMB target/region within the physical device
>> + *
>> + * Return: NULL if there is no rpmb device associated with the parent dev=
ice
>> + */
>> +struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target)
>> +{
>> +       struct device_with_target t;
>> +
>> +       if (!parent)
>> +               return NULL;
>> +
>> +       t.dev =3D parent;
>> +       t.target =3D target;
>> +
>> +       return rpmb_dev_find_device(&t, match_by_parent);
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_find_by_device);
>
> Is this what the TEE driver would be calling to find the rpmb device/partit=
ion?

yes, that's the idea.

>> +
>> +/**
>> + * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsys=
tem
>> + * @rdev: the rpmb device to unregister
>> + * Return:
>> + * *        0 on success
>> + * *        -EINVAL on wrong parameters
>> + */
>> +int rpmb_dev_unregister(struct rpmb_dev *rdev)
>> +{
>> +       if (!rdev)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&rdev->lock);
>> +       rpmb_cdev_del(rdev);
>
> I can't find the function above. I guess it should be included as a
> part of the patch too?

Sorry for the confusion, this is leftover from original version
Will be removed in next iteration.

>> +       device_del(&rdev->dev);
>> +       mutex_unlock(&rdev->lock);
>> +
>> +       rpmb_dev_put(rdev);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
>
> [...]
>
>> +/**
>> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
>> + * @dev: storage device of the rpmb device
>> + * @target: RPMB target/region within the physical device
>> + * @ops: device specific operations
>> + *
>> + * Return: a pointer to rpmb device
>> + */
>> +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
>> +                                  const struct rpmb_ops *ops)
>> +{
>> +       struct rpmb_dev *rdev;
>> +       int id;
>> +       int ret;
>> +
>> +       if (!dev || !ops)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->program_key)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->get_capacity)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->get_write_counter)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->write_blocks)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ops->read_blocks)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
>> +       if (!rdev)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       id =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
>> +       if (id < 0) {
>> +               ret =3D id;
>> +               goto exit;
>> +       }
>> +
>> +       mutex_init(&rdev->lock);
>> +       rdev->ops =3D ops;
>> +       rdev->id =3D id;
>> +       rdev->target =3D target;
>> +
>> +       dev_set_name(&rdev->dev, "rpmb%d", id);
>> +       rdev->dev.class =3D &rpmb_class;
>> +       rdev->dev.parent =3D dev;
>> +
>> +       rpmb_cdev_prepare(rdev);
>
> Ditto.

same as my last comment
>> +
>> +       ret =3D device_register(&rdev->dev);
>> +       if (ret)
>> +               goto exit;
>> +
>> +       rpmb_cdev_add(rdev);
>
> Ditto.

same as above.

>> +
>> +       dev_dbg(&rdev->dev, "registered device\n");
>> +
>> +       return rdev;
>> +
>> +exit:
>> +       if (id >=3D 0)
>> +               ida_simple_remove(&rpmb_ida, id);
>> +       kfree(rdev);
>> +       return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(rpmb_dev_register);
>> +
>
> [...]
>


[1] https://source.denx.de/u-boot/u-boot/-/commit/4853ad3e13e21462a86e09caee4=
ea27ae68e764b

Best Regards,
Shyam

--===============3195800137800195423==--

