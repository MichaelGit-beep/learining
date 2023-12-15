
def list_dir_content(command):
    import subprocess
    try:
        output = subprocess.check_output(command, shell=True, text=True, stderr=subprocess.STDOUT)
        returncode = 0
    except subprocess.CalledProcessError as e:
        output = e.output
        returncode = e.returncode
    return output, returncode

# Example usage:
command_to_run = "ls -la /path/to/directory"
output, returncode = run_shell_command(command_to_run)
print(output)
print(f"Return Code: {returncode}")