# opscode-monitoring-cookbook

Runs Omnibus to build a Omnibus Monitoring installer package.  This enables
the use of a Test Kitchen-driven build farm.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['omnibus']['project']</tt></td>
    <td>String</td>
    <td>The project for Omnibus to build</td>
    <td><tt>opscode-monitoring</tt></td>
  </tr>
  <tr>
    <td><tt>['omnibus']['build_dir']</tt></td>
    <td>String</td>
    <td>The directory from which to run Omnibus</td>
    <td><tt>/home/vagrant/opscode-monitoring</tt></td>
  </tr>
</table>

## Usage

### opscode-monitoring::default

Include `opscode-monitoring` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[omnibus::default]",
    "recipe[opscode-monitoring::default]"
  ]
}
```

Note that `omnibus::default` _must_ be in the run list before
`opscode-monitoring::default`, as the latter assumes it is running on an
already-prepared Omnibus build node.
