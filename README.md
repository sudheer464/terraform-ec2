Terraform helps create AWS resources.

How to run the terraform? 

To validate

`$ terraform validate`

If no template errors are found you can run a plan:
`$ terraform plan`
This will show you how many resources will be created

When you are ready to deploy:

`$ terraform apply`

You will need to input certain variables at each prompt (such access keys/secrets , ami ID's etc)

When you are done with the hosts, please clean up:

`$ terraform plan -destroy`
This will show us which resources are going to be destroye

To apply this:
`$ terraform destroy`
