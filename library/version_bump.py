from ansible.module_utils.basic import *

FIELDS = {
  "current_version": {"default": "1.0.0", "type": "str"},
  "bump": {"default": "patch", "type": "str"},
  "bumped_version": {"default": None, "type": "str"},
}

def main():
  module = AnsibleModule(argument_spec=FIELDS)
  bump = module.params["bump"]
  current_version_list = list(map(lambda x: int(x), module.params["current_version"].split(".")))
  if bump == 'mayor':
    current_version_list[2] = 0
    current_version_list[1] = 0
    current_version_list[0] += 1
  if bump == 'minor':
    current_version_list[2] = 0
    current_version_list[1] += 1
  if bump == 'patch':
    current_version_list[2] += 1
  bumped_version = '.'.join(list(map(lambda x: str(x), current_version_list)))
  module.params.update({"bumped_version": bumped_version})
  module.exit_json(changed=True, meta=module.params)

if __name__ == '__main__':
  main()
