import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _controller      = TextEditingController();
  final _firestore       = FirebaseFirestore.instance;
  bool  _isSending       = false;

  String get _author {
    final email = FirebaseAuth.instance.currentUser?.email ?? '';
    return email.contains('@') ? email.split('@').first : 'Anonymous';
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _isSending = true);
    try {
      await _firestore.collection('comments').add({
        'text': text,
        'author': _author,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send message.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Community', style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.w700, color: textColor,
                )),
                Text('Share your thoughts about AGU', style: GoogleFonts.inter(fontSize: 14, color: subColor)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.teal));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat_bubble_outline_rounded, size: 52, color: subColor),
                        const SizedBox(height: 12),
                        Text('No messages yet', style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600, color: textColor,
                        )),
                        const SizedBox(height: 4),
                        Text('Be the first to share something!', style: GoogleFonts.inter(fontSize: 13, color: subColor)),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final doc    = snapshot.data!.docs[i];
                    final text   = doc['text']  as String? ?? '';
                    final author = doc['author'] as String? ?? 'Anonymous';
                    final ts     = doc['timestamp'] as Timestamp?;
                    final time   = ts != null
                        ? DateFormat('MMM d, h:mm a').format(ts.toDate())
                        : '';
                    final isMine = author == _author;

                    return Align(
                      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.72,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: isMine ? AppColors.tealGradient : null,
                            color: isMine ? null : (isDark ? const Color(0x1EFFFFFF) : const Color(0xCCFFFFFF)),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isMine ? 16 : 4),
                              bottomRight: Radius.circular(isMine ? 4 : 16),
                            ),
                            border: isMine ? null : Border.all(
                              color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (!isMine)
                                Text(author, style: GoogleFonts.inter(
                                  fontSize: 11, fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.teal : AppColors.tealDark,
                                )),
                              if (!isMine) const SizedBox(height: 2),
                              Text(text, style: GoogleFonts.inter(
                                fontSize: 14, color: isMine ? Colors.white : textColor,
                              )),
                              const SizedBox(height: 4),
                              Text(time, style: GoogleFonts.inter(
                                fontSize: 10,
                                color: isMine ? Colors.white.withValues(alpha: 0.7) : subColor,
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPad + 90),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0x1EFFFFFF) : const Color(0xCCFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: GoogleFonts.inter(color: textColor, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Write a message...',
                            hintStyle: GoogleFonts.inter(color: subColor, fontSize: 14),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                      GestureDetector(
                        onTap: _isSending ? null : _send,
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            gradient: AppColors.tealGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _isSending
                              ? const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
