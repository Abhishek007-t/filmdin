import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedTab(),
    const SearchTab(),
    const JobsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppTheme.darkGrey, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppTheme.black,
          selectedItemColor: AppTheme.gold,
          unselectedItemColor: AppTheme.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              activeIcon: Icon(Icons.work),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// ─── FEED TAB ───────────────────────────────────────────
class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'FILMDIN',
                  style: TextStyle(
                    color: AppTheme.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: AppTheme.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.message_outlined,
                        color: AppTheme.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Feed Posts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _dummyPosts.length,
              itemBuilder: (context, index) {
                final post = _dummyPosts[index];
                return _PostCard(post: post);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy post data
final List<Map<String, String>> _dummyPosts = [
  {
    'name': 'Anurag Kashyap',
    'role': 'Director',
    'time': '2 hours ago',
    'content':
        'Just wrapped up principal photography on our new indie project. 47 days of shooting in the mountains. Grateful for this incredible crew who gave everything. Cinema is alive! 🎬',
    'likes': '234',
    'comments': '45',
  },
  {
    'name': 'Deepika Sharma',
    'role': 'Cinematographer',
    'time': '5 hours ago',
    'content':
        'Looking for a gaffer and key grip for a 10-day commercial shoot in Mumbai starting March 20. DM me if interested. Rate negotiable for the right team.',
    'likes': '89',
    'comments': '32',
  },
  {
    'name': 'Rahul Verma',
    'role': 'Actor',
    'time': '1 day ago',
    'content':
        'Thrilled to announce I have been cast in my first feature film! Years of hard work finally paying off. Never give up on your dreams. More details soon!',
    'likes': '512',
    'comments': '98',
  },
];

class _PostCard extends StatelessWidget {
  final Map<String, String> post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              // Avatar
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.gold,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: Text(
                    post['name']![0],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['name']!,
                      style: const TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${post['role']} • ${post['time']}',
                      style: const TextStyle(
                        color: AppTheme.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Follow Button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.gold),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Follow',
                  style: TextStyle(
                    color: AppTheme.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Post Content
          Text(
            post['content']!,
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              _ActionButton(
                icon: Icons.favorite_border,
                label: post['likes']!,
              ),
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.comment_outlined,
                label: post['comments']!,
              ),
              const SizedBox(width: 24),
              _ActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.grey, size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: AppTheme.grey, fontSize: 13),
        ),
      ],
    );
  }
}

// ─── SEARCH TAB ─────────────────────────────────────────
class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Discover', style: AppTheme.heading),
            const SizedBox(height: 16),
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.darkGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                style: TextStyle(color: AppTheme.white),
                decoration: InputDecoration(
                  hintText: 'Search filmmakers, actors...',
                  hintStyle: TextStyle(color: AppTheme.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: AppTheme.grey),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Browse by Role', style: AppTheme.subheading),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                'Director',
                'Actor',
                'Cinematographer',
                'Producer',
                'Editor',
                'Sound Designer',
                'Screenwriter',
              ].map((role) => _RoleChip(role: role)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String role;
  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.darkGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.gold.withOpacity(0.3)),
      ),
      child: Text(
        role,
        style: const TextStyle(color: AppTheme.white, fontSize: 13),
      ),
    );
  }
}

// ─── JOBS TAB ───────────────────────────────────────────
class JobsTab extends StatelessWidget {
  const JobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jobs & Casting', style: AppTheme.heading),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.gold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '+ Post',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  _JobCard(
                    title: 'Lead Actor — Male 25-35',
                    project: 'Indie Feature Film',
                    location: 'Mumbai',
                    type: 'Casting Call',
                  ),
                  _JobCard(
                    title: 'Cinematographer Needed',
                    project: 'Short Film — 5 Days',
                    location: 'Delhi',
                    type: 'Crew',
                  ),
                  _JobCard(
                    title: 'Film Editor — Post Production',
                    project: 'Documentary Project',
                    location: 'Remote',
                    type: 'Post Production',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String title;
  final String project;
  final String location;
  final String type;
  const _JobCard({
    required this.title,
    required this.project,
    required this.location,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              type,
              style: const TextStyle(
                color: AppTheme.gold,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            project,
            style: const TextStyle(color: AppTheme.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppTheme.grey,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      color: AppTheme.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.gold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── PROFILE TAB ────────────────────────────────────────
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppTheme.darkGrey,
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppTheme.gold,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Abhishek',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Director • Mangaluru, Karnataka',
                    style: TextStyle(color: AppTheme.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(label: 'Projects', value: '0'),
                      _StatItem(label: 'Followers', value: '0'),
                      _StatItem(label: 'Following', value: '0'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Edit Profile Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.gold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: AppTheme.gold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Credits Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Credits', style: AppTheme.heading),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.movie_creation_outlined,
                          color: AppTheme.grey,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No credits yet',
                          style: TextStyle(
                            color: AppTheme.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add your film projects and credits',
                          style: TextStyle(color: AppTheme.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.gold,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            '+ Add Credit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppTheme.grey, fontSize: 12),
        ),
      ],
    );
  }
}