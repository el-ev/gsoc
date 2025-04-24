import os
import re
from github import Github

def main():
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        print("Error: GITHUB_TOKEN environment variable not set")
        exit(1)
    
    username = os.environ.get("GITHUB_USERNAME")
    if not username:
        print("Error: GITHUB_USERNAME environment variable not set")
        exit(1)
    
    g = Github(token)
    repo = g.get_repo("llvm/llvm-project")
    
    query = f"is:pr author:{username} repo:llvm/llvm-project"
    prs = g.search_issues(query)
    
    cir_prs = []
    for issue in prs:
        if "[CIR]" in issue.title:
            pr = repo.get_pull(issue.number)
            
            if pr.state == "closed":
                status = "Done"
                if pr.merged:
                    closed_str = ""
                else:
                    closed_str = " (Closed)"
            else:
                status = "In Progress"
                closed_str = ""
            
            date_str = pr.created_at.strftime("%Y-%m-%d")
            
            cir_prs.append({
                "number": pr.number,
                "title": pr.title,
                "url": pr.html_url,
                "status": status,
                "date": date_str,
                "closed": closed_str,
                "merged": pr.merged
            })
    
    tasks_path = "tasks.md"
    
    with open(tasks_path, "r") as f:
        content = f.read()
    
    in_progress_prs = [pr for pr in cir_prs if pr["status"] == "In Progress"]
    in_progress_lines = []
    for pr in in_progress_prs:
        in_progress_lines.append(
            f"- {pr['date']} [#{pr['number']}]({pr['url']}) {pr['title']}"
        )
    
    in_progress_content = "<!-- INPROGRESS-BEGIN -->\n"
    if in_progress_lines:
        in_progress_content += "\n".join(in_progress_lines) + "\n"
    in_progress_content += "<!-- INPROGRESS-END -->"
    
    done_prs = [pr for pr in cir_prs if pr["status"] == "Done"]
    done_lines = []
    for pr in done_prs:
        if pr["closed"] and not pr["merged"]:
            done_lines.append(
                f"- ~~{pr['date']} [#{pr['number']}]({pr['url']}) {pr['title']}~~{pr['closed']}"
            )
        else:
            done_lines.append(
                f"- {pr['date']} [#{pr['number']}]({pr['url']}) {pr['title']}"
            )
    
    done_content = "<!-- DONE-BEGIN -->\n"
    if done_lines:
        done_content += "\n".join(done_lines) + "\n"
    done_content += "<!-- DONE-END -->"
    
    content = re.sub(
        r"<!-- INPROGRESS-BEGIN -->.*?<!-- INPROGRESS-END -->", 
        in_progress_content, 
        content, 
        flags=re.DOTALL
    )
    
    content = re.sub(
        r"<!-- DONE-BEGIN -->.*?<!-- DONE-END -->", 
        done_content, 
        content, 
        flags=re.DOTALL
    )
    
    with open(tasks_path, "w") as f:
        f.write(content)
    
    print("Tasks file updated successfully")

if __name__ == "__main__":
    main()
