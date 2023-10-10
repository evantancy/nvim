import argparse

from huggingface_hub import scan_cache_dir

parser = argparse.ArgumentParser()
parser.add_argument(
    "--execute", help="Execute deletion of cached models", action="store_true"
)
args = parser.parse_args()

print(scan_cache_dir().repos)

cached_repos = scan_cache_dir().repos
print(f"Found {len(cached_repos)} repos")
commit_hashes = set()
for repo in cached_repos:
    print(f"{repo.repo_id}, size on disk: {repo.size_on_disk_str}")
    for revision in repo.revisions:
        commit_hashes.add(revision.commit_hash)

delete_strategy = scan_cache_dir().delete_revisions(*commit_hashes)
print(f"Will free {delete_strategy.expected_freed_size_str}")

if args.execute:
    delete_strategy.execute()
