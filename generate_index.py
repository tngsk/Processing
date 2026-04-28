import os

categories = [
    "01_Games_and_Interactive",
    "02_Animation_and_Physics",
    "03_Drawing_and_Visuals",
    "04_Math_and_Algorithms",
    "05_Basics_and_Misc"
]

index_content = "# Project Index\n\n"

for category in categories:
    index_content += f"## {category}\n"
    if os.path.exists(category):
        subdirs = [d for d in os.listdir(category) if os.path.isdir(os.path.join(category, d))]
        subdirs.sort()
        for subdir in subdirs:
            index_content += f"- [{subdir}](./{category}/{subdir})\n"
    else:
        index_content += "- (Directory not found)\n"
    index_content += "\n"

with open("INDEX.md", "w") as f:
    f.write(index_content)

print("INDEX.md generated successfully.")