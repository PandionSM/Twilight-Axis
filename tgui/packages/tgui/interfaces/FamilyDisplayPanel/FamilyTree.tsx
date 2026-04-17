import { Box, Section } from 'tgui-core/components';

import { FamilyTreeBranch } from './FamilyTreeBranch';
import type { FamilyTreeNode } from './types';

const scrollStyle = {
  overflowX: 'auto',
  padding: '8px 0 12px',
} as const;

const innerStyle = {
  alignItems: 'flex-start',
  display: 'inline-flex',
  gap: '32px',
  justifyContent: 'center',
  minWidth: '100%',
} as const;

export const FamilyTree = ({ tree }: { tree: FamilyTreeNode[] }) => (
  <Section title="Family Tree">
    <Box style={scrollStyle}>
      <Box style={innerStyle}>
        {tree.map((root, index) => (
          <FamilyTreeBranch
            key={`family-root-${root.name}-${index}`}
            node={root}
          />
        ))}
      </Box>
    </Box>
  </Section>
);
