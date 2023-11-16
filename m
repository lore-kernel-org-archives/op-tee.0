From: Don Harbin <don.harbin@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Thu, 16 Nov 2023 08:14:33 -0700
Message-ID: 
 <CA+HB5jDg=UBdWYe01QynJnL0iC6n0w06OS8EiwD+9aBBBCPULA@mail.gmail.com>
In-Reply-To: <73DDF5E9-B39C-4321-AA68-FE9EDE1D65B7@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7509265932987805977=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7509265932987805977==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Jan,
>  It works for me now..
This great news, glad to hear it's working for you!

> It would just be great if the documentation could be changed accordingly.
Agreed, and this is where it would be great if you could help out. ;).  It
would be helpful if you could take this on since community docs are found
to be most useful when the actual users contribute.  If you would be
willing, here's a couple suggestions:
- First, post this as a docs issue here:
https://github.com/OP-TEE/optee_docs/issues
- And second, it would be awesome if you could create a Pull Request
against that issue for the changes you'd recommend to the docs in that same
repo.

Thanks in advance and feel free to reach out to me if you have any
questions,

Don Harbin

TrustedFirmware Community Manager

don.harbin(a)linaro.org


On Thu, 16 Nov 2023 at 05:26, Jan Claußen <jan.claussen10@web.de> wrote:

> @Jérome You solution worked well. Thank you!
>
> @Étienne It works for me now, so actually there is no need for me. I also
> think that for the sake of transparency, it is letting the signing step be
> done by official tools like openssl or pkcs11-tool is the better solution!
> It would just be great if the documentation could be changed accordingly.
> Make clear that the pubkey must be used for the digest and stitch steps
> Fix the pkcs11-tool command example
>
> Maybe mention that the --ta-version flag must be set for some TAs e.g.
> oemcrypto. This has taken me quite a while to find out. Had to look at the
> make commands in Yocto.
>
> Cheers,
> Jan
>

--===============7509265932987805977==--

