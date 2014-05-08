# Recipe:: bgp
#
# Copyright 2014, Bao Nguyen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

a = {
	:name => "sv2",
	:network => "204.0.0.0/24",
	:options => "",
	:condition => "accept"
}

b = {
	:name => "sjc1",
	:network => "198.38.13.0/24",
	:options => "",
	:condition => "accept"
}

asn28 = {
	:ip => "1.1.1.1"
	:asn => "28"
}

bird_net_filter "sv2" do
	acls [a]
end

bird_net_filter "sjc1" do
	acls [b]
end

bird_bgp "ix" do
	as "100"
	import "sv2"
	export "sjc1"
	neightbor [asn28]
	options ["multihop","something else"]
end
