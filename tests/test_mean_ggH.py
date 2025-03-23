import sys
import ROOT

f = ROOT.TFile.Open('hist_ggH.root')
keys = [k.GetName() for k in f.GetListOfKeys()]

required_keys = ['ggH_m_1', 'ggH_m_2']

print('\n'.join(keys))
for required_key in required_keys:
    if not required_key in keys:
        print(f'Required key not found. {required_key}')
        sys.exit(1)

mean = f.ggH_m_2.GetMean()
if abs(mean - 0.6701) > 0.001:
    print(f'Mean of ggH_m_2 is different: {mean}')
    sys.exit(1)
