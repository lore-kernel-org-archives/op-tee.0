From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Thu, 14 May 2020 03:28:18 +0300
Message-ID: <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
In-Reply-To: <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3883986521176969220=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3883986521176969220==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

The implementation looks solid but how or who could possibly test this?

I do posses (personally, not from employer) bunch of ARM boards but my
TZ knowledge is somewhat limited (e.g. how can I get something running
in TZ).

/Jarkko


--===============3883986521176969220==--

