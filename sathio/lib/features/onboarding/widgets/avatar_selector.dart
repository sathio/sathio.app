import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final int selectedAvatarIndex;
  final VoidCallback onTap;

  const AvatarSelector({
    super.key,
    required this.selectedAvatarIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Avatar Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/avatars/avatar_$selectedAvatarIndex.png', // Assumes android/assets/avatars/ exists, logic will need valid assets.
                // For now, using placeholder or errorBuilder if assets missing?
                // User said "12 SVG/PNG assets from UI_UX.md". I'll assume they exist or use network for now?
                // Better: Use a reliable placeholder or generate meaningful colors/letters if missing.
                // Re-reading: "grid (12 SVG/PNG assets from UI_UX.md)".
                // I will assume assets are named `avatar_1.png`...`avatar_12.png`.
                // If not, I should probably use a placeholder color based on index.
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors
                      .primaries[selectedAvatarIndex % Colors.primaries.length]
                      .shade200,
                  child: Center(
                    child: Text(
                      selectedAvatarIndex.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Camera Badge
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF58220), // Orange
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarSelectionSheet extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AvatarSelectionSheet({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Choose Avatar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111111),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Grid
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 12, // 12 presets
              itemBuilder: (context, index) {
                final avatarIdx = index + 1;
                final isSelected = selectedIndex == avatarIdx;

                return GestureDetector(
                  onTap: () => onSelect(avatarIdx),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: const Color(0xFFF58220), width: 3)
                          : null,
                    ),
                    padding: const EdgeInsets.all(2), // Space for border
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/avatars/avatar_$avatarIdx.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors
                              .primaries[avatarIdx % Colors.primaries.length]
                              .shade200,
                          child: Center(
                            child: Text(
                              "$avatarIdx",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Placeholder for Camera Option (Functionality later)
          OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement Camera/Gallery
              Navigator.pop(context);
            },
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Take Photo'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF111111),
              side: const BorderSide(color: Color(0xFFE8E8E8)),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
