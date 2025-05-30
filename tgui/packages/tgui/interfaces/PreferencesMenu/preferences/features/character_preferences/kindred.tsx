import { Feature } from "../base";
import { FeatureDropdownInput } from '../dropdowns';

export const vtm_morality_path: Feature<string> = {
  name: 'Path',
  description: 'The morality that your character subscribes to.',
  component: FeatureDropdownInput,
};
